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

/// A class for creating, storing and activating `NSLayoutConstraint`s based on arbitrary conditions.
public class DynamicLayout<Environment> {

    /// A struct defining a condition to be met for constraints to be activated.
    public struct Predicate {

        let predicate: (Environment) -> Bool

        /// Initializes a new `Predicate` with the given closure.
        ///
        /// - Parameter predicate: The closure.
        public init(_ predicate: @escaping (Environment) -> Bool) {
            self.predicate = predicate
        }
    }

    /// A struct for holding a `Predicate` and its constraints.
    public struct Context {

        var predicate: Predicate

        var constraints: Set<NSLayoutConstraint> = []

        var finalize: (Context) -> Void

        init(predicate: Predicate, finalize: @escaping (Context) -> Void) {
            self.predicate = predicate
            self.finalize = finalize
        }
    }

    private var predicatesAndConstraints: [(Predicate, Set<NSLayoutConstraint>)] = []

    private var activeConstraints: Set<NSLayoutConstraint> = []

    var activeConstraints_forTestingOnly: [NSLayoutConstraint] {
        return .init(activeConstraints)
    }

    /// The entry point for adding constraints. The initial `Context` is always `true`.
    /// Feel free to add constraints that are always active regardless of any other conditions to this context.
    ///
    /// - Parameter using: A closure that receives the initial `Context`.
    public func addLayouts(_ using: (inout Context) -> Void) {
        var ctx = Context(
            predicate: .always,
            finalize: finalize
        )
        using(&ctx)
        finalize(ctx)
        // Activate the "global/always" constraints immediately,
        let alwaysConstraints = predicatesAndConstraints.last!.1
        Array(alwaysConstraints).activate()
        activeConstraints = alwaysConstraints
        // Remove any empty sets of constraints. No need to evaluate the predicates
        // if they have no constraints to activate.
        predicatesAndConstraints.removeAll { $0.1.isEmpty }
    }

    /// Activates the appropriate constraints after evaluating all `Predicate`s against the given `Environment`.
    ///
    /// - Parameter environment: The `Environment`.
    public func updateActiveConstraints(with environment: Environment) {
        let newConstraints: Set<NSLayoutConstraint> = predicatesAndConstraints.reduce(into: []) { result, tuple in
            let (predicate, constraints) = tuple
            if predicate.evaluate(with: environment) {
                result.formUnion(constraints)
            }
        }
        let constraintsToDeactivate = activeConstraints.subtracting(newConstraints)
        let constraintsToActivate = newConstraints.subtracting(activeConstraints)
        Array(constraintsToDeactivate).deactivate()
        Array(constraintsToActivate).activate()
        activeConstraints = newConstraints
    }

    private func finalize(_ ctx: Context) {
        predicatesAndConstraints.append((ctx.predicate, ctx.constraints))
    }
}
