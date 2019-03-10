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
            return otherwise?.activeConstraints(for: environment) ?? []
        }
    }

    /// Adds a new nested `Context` to the receiver with the given `Predicate`.
    ///
    /// - Parameters:
    ///   - predicate: The `Predicate` that must be `true` for the constraints
    ///                to be applied.
    ///   - when: The closure where constraints are configured.
    ///   - otherwise: The closure where constraints are configured when the
    ///                given `Predicate` is `false`; defaults to a noop closure.
    ///   - whenCtx: The newly created `Context`.
    ///   - otherwiseCtx: The newly created "otherwise" `Context`.
    public mutating func when(_ predicate: DynamicLayout.Predicate, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void, otherwise: (_ otherwiseCtx: inout DynamicLayout.Context) -> Void = { _ in }) {
        var ctx = DynamicLayout.Context(predicate: predicate)
        var otherCtx = DynamicLayout.Context(predicate: !predicate)
        when(&ctx)
        otherwise(&otherCtx)
        ctx.otherwise = otherCtx
        children.append(ctx)
    }

    /// Adds a new nested `Context` to the receiver with the given `Predicate`.
    ///
    /// - Parameters:
    ///   - predicate: The `Predicate` that must be `true` for the constraints
    ///                to be applied.
    ///   - when: The closure where constraints are configured.
    ///   - whenCtx: The newly created `Context`.
    public mutating func when(_ predicate: DynamicLayout.Predicate, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void) {
        self.when(predicate, when, otherwise: { _ in })
    }

    /// Adds a new nested `Context` to the receiver with the given predicate
    /// closure.
    ///
    /// - Parameters:
    ///   - predicate: The closure that must be `true` for the constraints to be
    ///                applied.
    ///   - env: The `Environment` supplied to the predicate closure.
    ///   - when: The closure where constraints are configured.
    ///   - otherwise: The closure where constraints are configured when the
    ///                given `Predicate` is `false`; defaults to a noop closure.
    ///   - whenCtx: The newly created `Context`.
    ///   - otherwiseCtx: The newly created "otherwise" `Context`.
    public mutating func when(_ predicate: @escaping (_ env: Environment) -> Bool, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void, otherwise: (_ otherwiseCtx: inout DynamicLayout.Context) -> Void = { _ in }) {
        self.when(.init(predicate), when, otherwise: otherwise)
    }

    /// Adds a new nested `Context` to the receiver with the given predicate
    /// closure.
    ///
    /// - Parameters:
    ///   - predicate: The closure that must be `true` for the constraints to be
    ///                applied.
    ///   - env: The `Environment` supplied to the predicate closure.
    ///   - when: The closure where constraints are configured.
    ///   - whenCtx: The newly created `Context`.
    public mutating func when(_ predicate: @escaping (_ env: Environment) -> Bool, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void) {
        self.when(predicate, when, otherwise: { _ in })
    }

    /// Adds constraints for an item in the receiving `Context`.
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

    /// Adds a new nested `Context` to the receiver. A predicate will be
    /// implicitly created that will evaluate to `true` when the current
    /// `Environment` is equal to the given value.
    ///
    /// For example, you might use this if your environment was an `enum`:
    ///
    ///     ctx.when(.someState) { newCtx in ... }
    ///
    /// rather than:
    ///
    ///     ctx.when(.init({ $0 == .someState })) { newCtx in ... }
    ///
    /// - Parameters:
    ///   - value: The desired value of the current `Environment`.
    ///   - when: The closure where constraints are configured.
    ///   - otherwise: The closure where constraints are configured when the
    ///                given `Predicate` is `false`; defaults to a noop closure.
    ///   - whenCtx: The newly created `Context`.
    ///   - otherwiseCtx: The newly created "otherwise" `Context`.
    public mutating func when(_ value: Environment, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void, otherwise: (_ otherwiseCtx: inout DynamicLayout.Context) -> Void) {
        self.when({ $0 == value }, when, otherwise: otherwise)
    }

    /// Adds a new nested `Context` to the receiver. A predicate will be
    /// implicitly created that will evaluate to `true` when the current
    /// `Environment` is equal to the given value.
    ///
    /// For example, you might use this if your environment was an `enum`:
    ///
    ///     ctx.when(.someState) { newCtx in ... }
    ///
    /// rather than:
    ///
    ///     ctx.when(.init({ $0 == .someState })) { newCtx in ... }
    ///
    /// - Parameters:
    ///   - value: The desired value of the current `Environment`.
    ///   - when: The closure where constraints are configured.
    ///   - whenCtx: The newly created `Context`.
    public mutating func when(_ value: Environment, _ when: (_ whenCtx: inout DynamicLayout.Context) -> Void) {
        self.when(value, when, otherwise: { _ in })
    }
}
