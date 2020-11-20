import UIKit

struct SingleConstraint: SingleConstraintGenerator {
    enum SecondItem {
        case `self`
        case parent
        case other(ConstrainableItem)

        fileprivate func item(for firstItem: ConstrainableItem) -> ConstrainableItem? {
            switch self {
            case .self:
                return firstItem
            case .parent:
                return firstItem.toItem ?? firstItem.parentView
            case .other(let other):
                return other
            }
        }
    }

    var firstAttribute: NSLayoutConstraint.Attribute
    var relation: NSLayoutConstraint.Relation
    var secondItem: SecondItem?
    var secondAttribute: NSLayoutConstraint.Attribute
    var multiplier: CGFloat
    var constant: CGFloat
    var priority: UILayoutPriority = .required
    var identifier: String?

    init(
        attribute firstAttribute: NSLayoutConstraint.Attribute,
        relatedBy relation: NSLayoutConstraint.Relation,
        to secondItem: SecondItem?,
        attribute secondAttribute: NSLayoutConstraint.Attribute,
        multiplier: CGFloat,
        constant: CGFloat,
        file: String,
        line: UInt
    ) {
        self.firstAttribute = firstAttribute
        self.relation = relation
        self.secondItem = secondItem
        self.secondAttribute = secondAttribute
        self.multiplier = multiplier
        self.constant = constant
        self.identifier = "\((file as NSString).lastPathComponent):\(line)"
    }

    func constraint(withItem firstItem: ConstrainableItem) -> NSLayoutConstraint {
        let secondItem = self.secondItem?.item(for: firstItem)
        #if DEBUG
            if secondAttribute == .notAnAttribute, secondItem != nil {
                FatalError.crash("Do not pass a second item when using 'notAnAttribute'.")
            }

            if firstItem === secondItem, firstAttribute == secondAttribute {
                FatalError.crash("Do not pass same item to 'to' and use the same attribute.")
            }
        #endif

        if secondItem == nil, secondAttribute != .notAnAttribute {
            FatalError.crash("You must have a parent view.")
            // Return a bogus constraint.
            return NSLayoutConstraint(item: firstItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        }

        let constraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.priority = priority
        constraint.identifier = identifier
        return constraint
    }
}
