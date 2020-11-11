import UIKit

extension ConstraintGroup {
    /// Returns a `ConstraintGroup` for aligning an item's edges to another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///   the `superview` if left as `nil`.
    ///   - insets: The desired insets; defaults to `.zero`.
    /// - Returns: A `ConstraintGroup` for aligning an item's edges to another
    ///   item.
    @inlinable
    public static func alignEdges(
        to secondItem: ConstrainableItem? = nil,
        insets: NSDirectionalEdgeInsets = .zero,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .top(to: secondItem, constant: insets.top, file: file, line: line),
            .leading(to: secondItem, constant: insets.leading, file: file, line: line),
            .bottom(to: secondItem, constant: -insets.bottom, file: file, line: line),
            .trailing(to: secondItem, constant: -insets.trailing, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's vertical edges to
    /// another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///   the `superview` if left as `nil`.
    ///   - leadingInset: The desired leading inset; defaults to zero.
    ///   - trailingInset: The desired trailing inset; defaults to zero.
    /// - Returns: A `ConstraintGroup` for aligning an item's vertical edges to
    ///   another item.
    @inlinable
    public static func alignVerticalEdges(
        to secondItem: ConstrainableItem? = nil,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .leading(to: secondItem, constant: leadingInset, file: file, line: line),
            .trailing(to: secondItem, constant: -trailingInset, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's horizontal edges to
    /// another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults
    ///   to the `superview` if left as `nil`.
    ///   - topInset: The desired top inset; defaults to zero.
    ///   - bottomInset: The desired bottom inset; defaults to zero.
    /// - Returns: A `ConstraintGroup` for aligning an item's horizontal edges
    ///   to another item.
    @inlinable
    public static func alignHorizontalEdges(
        to secondItem: ConstrainableItem? = nil,
        topInset: CGFloat = 0,
        bottomInset: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .top(to: secondItem, constant: topInset, file: file, line: line),
            .bottom(to: secondItem, constant: -bottomInset, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for centering an item inside another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults
    ///   to the `superview` if left as `nil`.
    /// - Returns: A `ConstraintGroup` for centering an item inside another
    ///   item.
    @inlinable
    public static func center(
        in secondItem: ConstrainableItem? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .centerX(to: secondItem, file: file, line: line),
            .centerY(to: secondItem, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for setting the size of an item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - size: The desired size.
    /// - Returns: A `ConstraintGroup` for setting the size of an item.
    @inlinable
    public static func size(
        _ relation: Relation,
        _ size: CGSize,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .fixedWidth(relation, size.width, file: file, line: line),
            .fixedHeight(relation, size.height, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for setting the size of an item.
    ///
    /// - Parameters:
    ///   - size: The desired size.
    /// - Returns: A `ConstraintGroup` for setting the size of an item.
    @inlinable
    public static func size(
        _ size: CGSize,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .size(.equal, size, file: file, line: line)
    }

    /// Returns a `ConstraintGroup` for matching the size of one item to another
    /// item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///   to the `superview` if left as `nil`.
    ///   - multiplier: The desired multiplier; defaults to `1`.
    ///   - constant: The constant; defaults to `0`.
    /// - Returns: A `ConstraintGroup` for matching the size of one item to
    ///   another item.
    @inlinable
    public static func relativeSize(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
    ) -> ConstraintGroup {
        .init(
            file: file,
            line: line,
            composedOf:
            .relativeWidth(relation, to: secondItem, multiplier: multiplier, constant: constant, file: file, line: line),
            .relativeHeight(relation, to: secondItem, multiplier: multiplier, constant: constant, file: file, line: line)
        )
    }
}
