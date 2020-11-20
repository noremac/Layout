import UIKit

public func Top(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: YAttribute = .top,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .top,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func Leading(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: XAttribute = .leading,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .leading,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func Bottom(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: YAttribute = .bottom,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .bottom,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func Trailing(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: XAttribute = .trailing,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .trailing,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func AlignEdges(
    _ edges: NSDirectionalRectEdge = .all,
    to secondItem: ConstrainableItem? = nil,
    insets: NSDirectionalEdgeInsets = .zero,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    MultipleConstraints {
        if edges.contains(.top) {
            Top(
                to: secondItem,
                constant: insets.top,
                file: file,
                line: line
            )
        }

        if edges.contains(.leading) {
            Leading(
                to: secondItem,
                constant: insets.leading,
                file: file,
                line: line
            )
        }

        if edges.contains(.bottom) {
            Bottom(
                to: secondItem,
                constant: -insets.bottom,
                file: file,
                line: line
            )
        }

        if edges.contains(.trailing) {
            Trailing(
                to: secondItem,
                constant: -insets.trailing,
                file: file,
                line: line
            )
        }
    }
}

public func Contained(
    _ edges: NSDirectionalRectEdge = .all,
    within secondItem: ConstrainableItem? = nil,
    insets: NSDirectionalEdgeInsets = .zero,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    MultipleConstraints {
        if edges.contains(.top) {
            Top(
                .greaterThanOrEqual,
                to: secondItem,
                constant: insets.top,
                file: file,
                line: line
            )
        }

        if edges.contains(.leading) {
            Leading(
                .greaterThanOrEqual,
                to: secondItem,
                constant: insets.leading,
                file: file,
                line: line
            )
        }

        if edges.contains(.bottom) {
            Bottom(
                .lessThanOrEqual,
                to: secondItem,
                constant: -insets.bottom,
                file: file,
                line: line
            )
        }

        if edges.contains(.trailing) {
            Trailing(
                .lessThanOrEqual,
                to: secondItem,
                constant: -insets.trailing,
                file: file,
                line: line
            )
        }
    }
}

public func Left(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: XAttribute = .left,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .left,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

public func Right(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: XAttribute = .right,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .right,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}
