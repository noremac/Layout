import UIKit

// MARK: Width

public func Width(
    _ relation: NSLayoutConstraint.Relation,
    _ constant: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .width,
        relatedBy: relation,
        to: nil,
        attribute: .notAnAttribute,
        multiplier: 1,
        constant: constant,
        file: file,
        line: line
    )
}

public func Width(
    _ constant: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    Width(
        .equal,
        constant,
        file: file,
        line: line
    )
}

public func Width(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: DimensionAttribute = .width,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .width,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

// MARK: Height

public func Height(
    _ relation: NSLayoutConstraint.Relation,
    _ constant: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .height,
        relatedBy: relation,
        to: nil,
        attribute: .notAnAttribute,
        multiplier: 1,
        constant: constant,
        file: file,
        line: line
    )
}

public func Height(
    _ constant: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    Height(
        .equal,
        constant,
        file: file,
        line: line
    )
}

public func Height(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    attribute: DimensionAttribute = .height,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .height,
        relatedBy: relation,
        to: secondItem.map(SingleConstraint.SecondItem.other) ?? .parent,
        attribute: attribute.attribute,
        multiplier: multiplier,
        constant: constant,
        file: file,
        line: line
    )
}

// MARK: Size

public func Size(
    _ size: CGSize,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    MultipleConstraints {
        Width(
            size.width,
            file: file,
            line: line
        )
        Height(
            size.height,
            file: file,
            line: line
        )
    }
}

public func Size(
    width: CGFloat,
    height: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    Size(
        CGSize(width: width, height: height),
        file: file,
        line: line
    )
}

public func Size(
    _ relation: NSLayoutConstraint.Relation = .equal,
    to secondItem: ConstrainableItem? = nil,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: String = #file,
    line: UInt = #line
) -> MultipleConstraintGenerator {
    MultipleConstraints {
        Width(
            relation,
            to: secondItem,
            multiplier: multiplier,
            constant: constant,
            file: file,
            line: line
        )
        Height(
            relation,
            to: secondItem,
            multiplier: multiplier,
            constant: constant,
            file: file,
            line: line
        )
    }
}

// MARK: Aspect ratio

public func AspectRatio(
    _ ratio: CGFloat,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    SingleConstraint(
        attribute: .width,
        relatedBy: .equal,
        to: .self,
        attribute: .height,
        multiplier: ratio,
        constant: 0,
        file: file,
        line: line
    )
}

public func AspectRatio(
    _ size: CGSize,
    file: String = #file,
    line: UInt = #line
) -> SingleConstraintGenerator {
    AspectRatio(
        size.width / size.height,
        file: file,
        line: line
    )
}
