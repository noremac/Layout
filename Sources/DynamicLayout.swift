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

public class DynamicLayout<Environment> {

    private var predicatesAndConstraints: [(Predicate, Set<NSLayoutConstraint>)] = []

    private var activeConstraints: Set<NSLayoutConstraint> = []

    internal var activeConstraints_forTestingOnly: [NSLayoutConstraint] {
        return .init(activeConstraints)
    }

    public struct Predicate {

        private let predicate: (Environment) -> Bool

        public init(_ predicate: @escaping (Environment) -> Bool) {
            self.predicate = predicate
        }

        func evaluate(with environment: Environment) -> Bool {
            return predicate(environment)
        }
    }

    public struct Context {

        fileprivate var predicate: Predicate

        fileprivate var constraints: Set<NSLayoutConstraint> = []

        private var finalize: (Context) -> Void

        init(predicate: Predicate, finalize: @escaping (Context) -> Void) {
            self.predicate = predicate
            self.finalize = finalize
        }

        public mutating func when(_ predicate: Predicate, file: StaticString = #file, line: UInt = #line, _ using: (inout Context) -> Void) {
            var ctx = Context(predicate: self.predicate && predicate, finalize: finalize)
            using(&ctx)
            finalize(ctx)
            if constraints.isEmpty {
                assertionFailure("Created a when clause and added no constraints to it", file: file, line: line)
            }
        }

        public mutating func addConstraints(for item: ConstrainableItem, _ groups: ConstraintGroup...) {
            constraints.formUnion(item.makeConstraints(groups: groups))
        }
    }

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

extension DynamicLayout.Context where Environment: Equatable {

    public mutating func when(_ value: Environment, file: StaticString = #file, line: UInt = #line, _ using: (inout DynamicLayout.Context) -> Void) {
        when(.init({ $0 == value }), file: file, line: line, using)
    }
}

// TODO: remove this
func foo() {
    let view = UIView()
    let layout = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
    layout.addLayouts { ctx in
        ctx.when(.verticallyRegular || .verticallyUnspecified || .widthGreaterThanOrEqualTo(1_024)) { ctx in
            ctx.addConstraints(
                for: view,
                .align(.leading)
            )

            ctx.when(.horizontallyCompact) { ctx in
                ctx.addConstraints(
                    for: view,
                    .align(.trailing)
                )
            }
        }
    }
    layout.updateActiveConstraints(with: .init(traitCollection: view.traitCollection, size: view.bounds.size))
}
