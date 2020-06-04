/*
 The MIT License (MIT)

 Copyright (c) 2019 Cameron Pulsford

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

/// A class for creating, storing, and activating `NSLayoutConstraint`s based on
/// arbitrary predicates.
///
/// `Context`'s are stored as a tree and thus may be nested. A child `Context`'s
/// `Predicate` is only evaluated if its parent's `Predicate` evaluates to
/// `true`.
///
/// The initial `Context` received in the `configure` block is always `true`.
/// Constraints that should always be active regardless of any state may
/// be added there.
public class DynamicLayout<Environment> {
    /// A struct for defining a condition to be met for constraints to be
    /// activated.
    public struct Predicate {
        /// The predicate.
        public let predicate: (Environment) -> Bool

        /// Initializes a new `Predicate` with the given closure.
        ///
        /// - Parameter predicate: The closure.
        public init(_ predicate: @escaping (Environment) -> Bool) {
            self.predicate = predicate
        }
    }

    /// A struct for holding a `Predicate` and its associated
    /// `NSLayoutConstraint`s.
    public struct Context {
        var predicate: Predicate

        var constraints: [NSLayoutConstraint] = []

        var actions: [(Environment) -> Void] = []

        var children: [Context] = []

        private var _otherwise: [Context]?

        /// This is a hack because the compiler won't let us write
        /// `var otherwise: Context?` as a regular stored property.
        /// "Value type 'DynamicLayout<Environment>.Context' cannot have a
        /// stored property that recursively contains it." It doesn't apply to
        /// arrays apparently.
        var otherwise: Context? {
            get {
                _otherwise?.first
            }
            set {
                _otherwise = newValue.map { [$0] }
            }
        }

        init(predicate: Predicate) {
            self.predicate = predicate
        }

        /// Inspects self and children/other for constraints or actions.
        var hasConstraintsOrActions: Bool {
            if !constraints.isEmpty || !actions.isEmpty {
                return true
            }
            if children.contains(where: { $0.hasConstraintsOrActions }) {
                return true
            }
            return otherwise?.hasConstraintsOrActions ?? false
        }
    }

    var mainContext: Context = .init(predicate: .always)

    var activeConstraints: Set<NSLayoutConstraint> = []

    /// Initializes a DynamicLayout.
    public init() {}

    /// Add constraints here. The closure receives the main `Context` whose
    /// `Predicate` will always evaluate to `true`. From here, create as many
    /// `Context`s as needed and nest them as desired.
    ///
    /// - Parameters:
    ///   - main: The closure where constraints are configured.
    ///   - ctx: The main `Context` whose `Predicate` is always `true`.
    ///
    /// - Note: You may add constraints that should always be active regardless
    ///   of any other condition to the main `Context`. These constraints will
    ///   not be activated until the first call to `updateActiveConstraints`.
    ///
    /// - Attention: A `fatalError` will be hit if this method is called more
    ///   than once.
    public func configure(file: StaticString = #file, line: UInt = #line, _ main: (_ ctx: inout Context) -> Void) {
        if !mainContext.constraints.isEmpty || !mainContext.actions.isEmpty || !mainContext.children.isEmpty {
            return FatalError.crash("\(#function) should only be called once", file, line)
        }
        main(&mainContext)
    }

    /// Walks the tree of `Context`s and activates all the constraints whose
    /// `Predicate`s are `true` in the given `Environment`.
    ///
    /// - Parameter environment: The `Environment` to use for evaluation.
    public func update(environment: Environment) {
        let contexts = mainContext.activeContexts(for: environment)
        let (newConstraints, actions) = contexts.reduce(into: ([NSLayoutConstraint](), [(Environment) -> Void]())) { result, context in
            result.0.append(contentsOf: context.constraints)
            result.1.append(contentsOf: context.actions)
        }
        let newSet = Set(newConstraints)
        var constraintsToDeactivate = [NSLayoutConstraint]()
        var constraintsToActivate = [NSLayoutConstraint]()
        for newConstraint in newSet {
            if !activeConstraints.contains(newConstraint) {
                constraintsToActivate.append(newConstraint)
            }
        }
        for oldConstraint in activeConstraints {
            if !newSet.contains(oldConstraint) {
                constraintsToDeactivate.append(oldConstraint)
            }
        }
        constraintsToDeactivate.deactivate()
        constraintsToActivate.activate()
        activeConstraints = newSet
        actions.forEach { $0(environment) }
    }
}