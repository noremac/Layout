import UIKit

public protocol MultipleConstraintGenerator {
    var priority: UILayoutPriority { get set }

    var identifier: String? { get set }

    func insertConstraints(withItem item: ConstrainableItem, into constraints: inout [NSLayoutConstraint])
}

public protocol SingleConstraintGenerator: MultipleConstraintGenerator {
    func constraint(withItem item: ConstrainableItem) -> NSLayoutConstraint
}

public extension SingleConstraintGenerator {
    func insertConstraints(withItem item: ConstrainableItem, into constraints: inout [NSLayoutConstraint]) {
        constraints.append(constraint(withItem: item))
    }
}
