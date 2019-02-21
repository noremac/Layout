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

public extension ConstraintGroup {

    /// Returns a `ConstraintGroup` for aligning an item's edges to another item.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - insets: The desired insets; defaults to `.zero`.
    /// - Returns: A `ConstraintGroup` for aligning an item's edges to another item.
    static func alignToEdges(
        of item: ConstrainableItem? = nil,
        insets: NSDirectionalEdgeInsets = .zero,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.top, of: item, offsetBy: insets.top, file: file, function: function, line: line),
            .align(.leading, of: item, offsetBy: insets.leading, file: file, function: function, line: line),
            .align(.bottom, of: item, offsetBy: -insets.bottom, file: file, function: function, line: line),
            .align(.trailing, of: item, offsetBy: -insets.trailing, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for aligning an item's vertical edges to another item.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - topInset: The desired top inset; defaults to zero.
    ///   - bottomInset: The desired bottom inset; defaults to zero.
    /// - Returns: A `ConstraintGroup` for aligning an item's vertical edges to another item.
    static func alignToVerticalEdges(
        of item: ConstrainableItem? = nil,
        topInset: CGFloat = 0,
        bottomInset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.top, of: item, offsetBy: topInset, file: file, function: function, line: line),
            .align(.bottom, of: item, offsetBy: -bottomInset, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for aligning an item's horizontal edges to another item.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - leadingInset: The desired leading inset; defaults to zero.
    ///   - trailingInset: The desired trailing inset; defaults to zero.
    /// - Returns: A `ConstraintGroup` for aligning an item's horizontal edges to another item.
    static func alignToHorizontalEdges(
        of item: ConstrainableItem? = nil,
        leadingInset: CGFloat = 0,
        trailingInset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.leading, of: item, offsetBy: leadingInset, file: file, function: function, line: line),
            .align(.trailing, of: item, offsetBy: -trailingInset, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for aligning an item's edges to another item's margins.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - insets: The desired insets; defaults to `.zero`.
    /// - Returns: A `ConstraintGroup` for aligning an item's edges to another item's margins.
    static func alignEdgesToMargins(
        of item: ConstrainableItem? = nil,
        insets: NSDirectionalEdgeInsets = .zero,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.top, to: .topMargin, of: item, offsetBy: insets.top, file: file, function: function, line: line),
            .align(.leading, to: .leadingMargin, of: item, offsetBy: insets.leading, file: file, function: function, line: line),
            .align(.bottom, to: .bottomMargin, of: item, offsetBy: -insets.bottom, file: file, function: function, line: line),
            .align(.trailing, to: .trailingMargin, of: item, offsetBy: -insets.trailing, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for centering an item inside another item.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    /// - Returns: A `ConstraintGroup` for centering an item inside another item.
    static func center(
        in item: ConstrainableItem? = nil,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.centerX, of: item, file: file, function: function, line: line),
            .align(.centerY, of: item, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for centering an item inside another item's margins.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    /// - Returns: A `ConstraintGroup` for centering an item inside another item's margins.
    static func centerWithinMargins(
        of item: ConstrainableItem? = nil,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .align(.centerX, to: .centerXWithinMargins, of: item, file: file, function: function, line: line),
            .align(.centerY, to: .centerYWithinMargins, of: item, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for setting the size of an item.
    ///
    /// - Parameters:
    ///   - size: The desired size.
    ///   - relation: The relation; defaults to `.equal`.
    /// - Returns: A `ConstraintGroup` for setting the size of an item.
    static func setSize(
        _ size: CGSize,
        _ relation: NSLayoutConstraint.Relation = .equal,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .setFixed(.width, relation, to: size.width, file: file, function: function, line: line),
            .setFixed(.height, relation, to: size.height, file: file, function: function, line: line)
            ])
    }

    /// Returns a `ConstraintGroup` for matching the size of one item to another item.
    ///
    /// - Parameters:
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - ratio: The desired ratio; defaults to `1`.
    ///   - constant: The constant; defaults to `0`.
    /// - Returns: A `ConstraintGroup` for matching the size of one item to another item.
    static func matchSize(
        of item: ConstrainableItem? = nil,
        _ relation: NSLayoutConstraint.Relation = .equal,
        ratio: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return .init(composedOf: [
            .setRelative(.width, relation, to: ratio, of: item, constant: constant, file: file, function: function, line: line),
            .setRelative(.height, relation, to: ratio, of: item, constant: constant, file: file, function: function, line: line)
            ])
    }
}
