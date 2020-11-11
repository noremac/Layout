import UIKit

/// A closure that takes a `ConstrainableItem` and returns an
/// `NSLayoutConstraint`.
public typealias ConstraintSpec = (ConstrainableItem) -> NSLayoutConstraint

@usableFromInline
func constraintGenerator(
    firstAttribute: NSLayoutConstraint.Attribute,
    relation: ConstraintGroup.Relation,
    secondItem: ConstrainableItem? = nil,
    secondAttribute: NSLayoutConstraint.Attribute?,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: StaticString,
    line: UInt
) -> ConstraintSpec {
    // swiftformat:disable redundantReturn
    return { firstItem in
        let toItem: ConstrainableItem?
        if secondAttribute == .notAnAttribute {
            toItem = nil
        } else {
            if let item = secondItem ?? firstItem.toItem ?? firstItem.parentView {
                toItem = item
            } else {
                FatalError.crash("To automatically relate your constraints to the parent view, your item must already be a part of the view hierarchy.", file, line)
                // Return nonsense, will only be executed in tests.
                return NSLayoutConstraint(item: firstItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            }
        }
        return NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation.constraintRelation,
            toItem: toItem,
            attribute: secondAttribute ?? firstAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}
