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

extension DynamicLayout.Context {

    func activeConstraints(for environment: Environment) -> [NSLayoutConstraint] {
        if predicate.evaluate(with: environment) {
            return children.reduce(into: constraints, { $0 += $1.activeConstraints(for: environment) })
        } else {
            return []
        }
    }

    /// Creates a new child `Context` in which to add constraints when the given `Predicate` is `true`.
    /// The `Predicate` will only be evaluated if all parent `Predicate`s are also `true`.
    ///
    /// - Parameters:
    ///   - predicate: The `Predicate`.
    ///   - using: A closure that receives the new `Context` to add constraints to.
    public mutating func when(_ predicate: DynamicLayout.Predicate, _ using: (inout DynamicLayout.Context) -> Void) {
        var ctx = DynamicLayout.Context(predicate: predicate)
        using(&ctx)
        children.append(ctx)
    }

    /// Adds constraints for an item in the receiver.
    ///
    /// - Parameters:
    ///   - item: The `ConstrainableItem`.
    ///   - groups: The `ConstraintGroup`s to create.
    @discardableResult
    public mutating func addConstraints(for item: ConstrainableItem, _ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        let constraints = item.makeConstraints(groups: groups)
        self.constraints += constraints
        return constraints
    }
}

extension DynamicLayout.Context where Environment: Equatable {

    /// Creates a new context in which to add constraints when the `Environment` is equal to the given value.
    /// The `Predicate` is implicitly `&&`d with all parent contexts.
    ///
    /// - Parameters:
    ///   - predicate: The Predicate`.
    ///   - using: A closure that receives the new `Context` to add constraints to.
    public mutating func when(_ value: Environment, _ using: (inout DynamicLayout.Context) -> Void) {
        when(.init({ $0 == value }), using)
    }
}
