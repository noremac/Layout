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

extension ConstraintGroup {

    /// Returns a `ConstraintGroup` for aligning an item's edges to another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
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
        return .init(
            file: file,
            line: line,
            composedOf:
            .align(.top, to: secondItem, constant: insets.top, file: file, line: line),
            .align(.leading, to: secondItem, constant: insets.leading, file: file, line: line),
            .align(.bottom, to: secondItem, constant: -insets.bottom, file: file, line: line),
            .align(.trailing, to: secondItem, constant: -insets.trailing, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's vertical edges to
    /// another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
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
        return .init(
            file: file,
            line: line,
            composedOf:
            .align(.leading, to: secondItem, constant: leadingInset, file: file, line: line),
            .align(.trailing, to: secondItem, constant: -trailingInset, file: file, line: line)
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
        return .init(
            file: file,
            line: line,
            composedOf:
            .align(.top, to: secondItem, constant: topInset, file: file, line: line),
            .align(.bottom, to: secondItem, constant: -bottomInset, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for centering an item inside another item.
    ///
    /// - Parameters:
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
    /// - Returns: A `ConstraintGroup` for centering an item inside another
    ///   item.
    @inlinable
    public static func center(
        in secondItem: ConstrainableItem? = nil,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            composedOf:
            .align(.centerX, to: secondItem, file: file, line: line),
            .align(.centerY, to: secondItem, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for setting the size of an item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - size: The desired size.
    /// - Returns: A `ConstraintGroup` for setting the size of an item.
    @inlinable
    public static func setSize(
        _ relation: Relation = .equal,
        to size: CGSize,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            composedOf:
            .setFixed(.width, relation, to: size.width, file: file, line: line),
            .setFixed(.height, relation, to: size.height, file: file, line: line)
        )
    }

    /// Returns a `ConstraintGroup` for matching the size of one item to another
    /// item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
    ///   - multiplier: The desired multiplier; defaults to `1`.
    ///   - constant: The constant; defaults to `0`.
    /// - Returns: A `ConstraintGroup` for matching the size of one item to
    ///   another item.
    @inlinable
    public static func setRelativeSize(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            composedOf:
            .setRelative(.width, relation, to: secondItem, multiplier: multiplier, constant: constant, file: file, line: line),
            .setRelative(.height, relation, to: secondItem, multiplier: multiplier, constant: constant, file: file, line: line)
        )
    }
}
