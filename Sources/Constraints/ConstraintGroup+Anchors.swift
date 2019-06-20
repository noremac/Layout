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
        return .init(
            file: file,
            line: line,
            specs: { item in
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
        })
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
        return .init(
            file: file,
            line: line,
            specs: { item in
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
        })
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
        return .init(
            file: file,
            line: line,
            specs: { item in
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
        })
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
        return .init(
            file: file,
            line: line,
            specs: { item in
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
        })
    }
}
