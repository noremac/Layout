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
/// `Context`'s are stored as a tree and may be nested. A child `Context`'s
/// `Predicate` is only evaluated if it's parent's `Predicate` evaluates to
/// `true`.
///
/// The initial `Context` received in the `addConstraints` block is always
/// `true`. Constraints that should always be active may be added there.
public class DynamicLayout<Environment> {

    /// A struct for defining a condition to be met for constraints to be
    /// activated.
    public struct Predicate {

        let predicate: (Environment) -> Bool

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

        var children: [Context] = []

        init(predicate: Predicate) {
            self.predicate = predicate
        }
    }

    var mainContext: Context = .init(predicate: .always)

    var activeConstraints: [NSLayoutConstraint] = []

    /// Add constraints here. The closure receives the main `Context` whose
    /// `Predicate` will always evaluate to `true`. From here, create as many
    /// `Context`s as needed and nest them as desired.
    ///
    /// - Parameter main: The closure where constraints are configured.
    /// - Parameter ctx: The main `Context` whose `Predicate` is always `true`.
    ///
    /// - Note: You may add constraints that should always be active regardless
    /// of any other condition to the main `Context`. These constraints will not
    /// be activated until the first call to `updateActiveConstraints`.
    public func addConstraints(_ main: (_ ctx: inout Context) -> Void) {
        main(&mainContext)
    }

    /// Walks the tree of `Context`s and activates all the constraints whose
    /// `Predicate`s are `true` in the given `Environment`.
    ///
    /// - Parameter environment: The `Environment` to use for evaluation.
    public func updateActiveConstraints(with environment: Environment) {
        let newConstraints = mainContext.activeConstraints(for: environment)
        let newSet = Set(newConstraints)
        let activeSet = Set(activeConstraints)
        let constraintsToDeactivate = Array(activeSet.subtracting(newSet))
        let constraintsToActivate = Array(newSet.subtracting(activeSet))
        constraintsToDeactivate.deactivate()
        constraintsToActivate.activate()
        activeConstraints = newConstraints
    }
}
