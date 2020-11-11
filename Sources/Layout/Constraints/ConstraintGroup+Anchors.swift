import UIKit

extension ConstraintGroup {
    /// Returns a `ConstraintGroup` for aligning an item after another item plus
    /// system spacing.
    ///
    /// - Parameters:
    ///   - firstAttribute: The first `XAttribute`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondAnchor: The second `XAttribute`.
    ///   - multiplier: The multiplier; defaults to 1.
    /// - Returns: A `ConstraintGroup` for aligning an item after another item
    ///   plus system spacing.
    @inlinable
    public static func align(
        _ firstAttribute: XAttribute,
        _ relation: Relation = .equal,
        toSystemSpacingAfter secondAnchor: NSLayoutXAxisAnchor,
        multiplier: CGFloat = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            spec: { item in
                let firstAnchor = firstAttribute.anchor(item)
                switch relation {
                case .lessThanOrEqual:
                    return firstAnchor.constraint(
                        lessThanOrEqualToSystemSpacingAfter: secondAnchor,
                        multiplier: multiplier
                    )
                case .equal:
                    return firstAnchor.constraint(
                        equalToSystemSpacingAfter: secondAnchor,
                        multiplier: multiplier
                    )
                case .greaterThanOrEqual:
                    return firstAnchor.constraint(
                        greaterThanOrEqualToSystemSpacingAfter: secondAnchor,
                        multiplier: multiplier
                    )
                }
            }
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item below another item plus
    /// system spacing.
    ///
    /// - Parameters:
    ///   - firstAttribute: The first `YAttribute`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondAnchor: The second `YAttribute`.
    ///   - multiplier: The multiplier; defaults to 1.
    /// - Returns: A `ConstraintGroup` for aligning an item below another item
    ///   plus system spacing.
    @inlinable
    public static func align(
        _ firstAttribute: YAttribute,
        _ relation: Relation = .equal,
        toSystemSpacingBelow secondAnchor: NSLayoutYAxisAnchor,
        multiplier: CGFloat = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            spec: { item in
                let firstAnchor = firstAttribute.anchor(item)
                switch relation {
                case .lessThanOrEqual:
                    return firstAnchor.constraint(
                        lessThanOrEqualToSystemSpacingBelow: secondAnchor,
                        multiplier: multiplier
                    )
                case .equal:
                    return firstAnchor.constraint(
                        equalToSystemSpacingBelow: secondAnchor,
                        multiplier: multiplier
                    )
                case .greaterThanOrEqual:
                    return firstAnchor.constraint(
                        greaterThanOrEqualToSystemSpacingBelow: secondAnchor,
                        multiplier: multiplier
                    )
                }
            }
        )
    }

    /// Returns a `ConstraintGroup` for matching an item's dimension to the
    /// space between the x positioning of two items.
    ///
    /// - Parameters:
    ///   - dimension: The dimension, either `.width` or `.height`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - firstAnchor: The first anchor.
    ///   - secondAnchor: The second anchor.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for matching an item's dimension to the
    ///   space between the x positioning of two items.
    @inlinable
    public static func match(
        _ dimension: DimensionAttribute,
        _ relation: Relation = .equal,
        toSpaceBetween firstAnchor: NSLayoutXAxisAnchor,
        and secondAnchor: NSLayoutXAxisAnchor,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            spec: { item in
                let anchor = dimension.anchor(item)
                let space: NSLayoutDimension = firstAnchor.anchorWithOffset(
                    to: secondAnchor
                )
                switch relation {
                case .lessThanOrEqual:
                    return anchor.constraint(
                        lessThanOrEqualTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                case .equal:
                    return anchor.constraint(
                        equalTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                case .greaterThanOrEqual:
                    return anchor.constraint(
                        greaterThanOrEqualTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                }
            }
        )
    }

    /// Returns a `ConstraintGroup` for matching an item's dimension to the
    /// space between the y positioning of two items.
    ///
    /// - Parameters:
    ///   - dimension: The dimension, either `.width` or `.height`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - firstAnchor: The first anchor.
    ///   - secondAnchor: The second anchor.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for matching an item's dimension to the
    ///   space between the y positioning of two items.
    @inlinable
    public static func match(
        _ dimension: DimensionAttribute,
        _ relation: Relation = .equal,
        toSpaceBetween firstAnchor: NSLayoutYAxisAnchor,
        and secondAnchor: NSLayoutYAxisAnchor,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            spec: { item in
                let anchor = dimension.anchor(item)
                let space: NSLayoutDimension = firstAnchor.anchorWithOffset(
                    to: secondAnchor
                )
                switch relation {
                case .lessThanOrEqual:
                    return anchor.constraint(
                        lessThanOrEqualTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                case .equal:
                    return anchor.constraint(
                        equalTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                case .greaterThanOrEqual:
                    return anchor.constraint(
                        greaterThanOrEqualTo: space,
                        multiplier: multiplier,
                        constant: constant
                    )
                }
            }
        )
    }
}
