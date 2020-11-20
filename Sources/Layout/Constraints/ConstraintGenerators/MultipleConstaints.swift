import UIKit

struct MultipleConstraints: MultipleConstraintGenerator {
    var constraintGenerators: [MultipleConstraintGenerator]
    var priority: UILayoutPriority = .required
    var identifier: String?

    init(@ArrayBuilder <MultipleConstraintGenerator> _ constraintGenerators: () -> [MultipleConstraintGenerator]) {
        self.constraintGenerators = constraintGenerators()
    }

    func insertConstraints(withItem item: ConstrainableItem, into constraints: inout [NSLayoutConstraint]) {
        let initialCount = constraints.count
        constraintGenerators.forEach { generator in
            generator.insertConstraints(withItem: item, into: &constraints)
        }
        for constraint in constraints[initialCount...] {
            constraint.priority = priority

            if let identifier = identifier {
                constraint.identifier = identifier
            }
        }
    }
}
