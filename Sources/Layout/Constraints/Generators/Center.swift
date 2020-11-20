import UIKit

public func CenterX(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: XAttribute = .centerX,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .centerX,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func CenterY(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: YAttribute = .centerY,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .centerY,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func Center(
    in secondItem: ConstrainableItem? = nil,
    offset: CGPoint = .zero,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    MultipleConstraints {
        CenterX(
            to: secondItem,
            constant: offset.x,
            file: file,
            line: line
        )
        CenterY(
            to: secondItem,
            constant: offset.y,
            file: file,
            line: line
        )
    }
}
