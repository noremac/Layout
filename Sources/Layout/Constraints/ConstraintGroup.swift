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

/// A struct that helps create constraints.
public struct ConstraintGroup {
    /// Shadows NSLayoutConstraint.Relation, but is closed instead of open.
    public enum Relation {
        /// The constraint requires the first attribute to be less than or equal
        /// to the modified second attribute.
        case lessThanOrEqual
        /// The constraint requires the first attribute to be exactly equal to
        /// the modified second attribute.
        case equal
        /// The constraint requires the first attribute to be greater than or
        /// equal to the modified second attribute.
        case greaterThanOrEqual

        internal var constraintRelation: NSLayoutConstraint.Relation {
            switch self {
            case .lessThanOrEqual:
                return .lessThanOrEqual
            case .equal:
                return .equal
            case .greaterThanOrEqual:
                return .greaterThanOrEqual
            }
        }
    }

    /// When this is `true` a string with this format:
    /// `"\(file)::\(line)"`is automatically added as each
    /// constraint's `identifier`.
    public static var debugConstraints = true

    @usableFromInline var specs: [ConstraintSpec]

    @usableFromInline var file: StaticString

    @usableFromInline var line: UInt

    /// The priority of this group of constraints.
    public var priority: UILayoutPriority = .required

    /// The identifier of this group of constraints.
    /// - SeeAlso: `ConstraintGroup.debugConstraints`.
    public var identifier: String?

    /// Initializes a `ConstraintGroup` with the given spec.
    ///
    /// - Parameters:
    ///   - spec: The spec.
    public init(file: StaticString, line: UInt, spec: @escaping ConstraintSpec) {
        self.specs = [spec]
        self.file = file
        self.line = line
    }

    /// Initializes a `ConstraintGroup` composed of other `ConstraintGroup`s.
    /// Use this to build your own convenience extensions using the existing
    /// functions as building blocks.
    ///
    /// - Parameters:
    ///   - groups: The groups to compose.
    @inlinable
    public init(file: StaticString, line: UInt, composedOf groups: ConstraintGroup...) {
        self.specs = groups.flatMap({ $0.specs })
        self.file = file
        self.line = line
    }

    /// Returns a `ConstraintGroup` for aligning an item's left anchor to
    /// another item's x anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `left` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's left anchor to
    ///   another item's x anchor.
    @inlinable
    public static func left(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: XAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .left,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's right anchor to
    /// another item's x anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `right` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's right anchor to
    ///   another item's x anchor.
    @inlinable
    public static func right(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: XAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .right,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's leading anchor to
    /// another item's x anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `leading` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's leading anchor to
    ///   another item's x anchor.
    @inlinable
    public static func leading(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: XAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .leading,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's trailing anchor to
    /// another item's x anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `trailing` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's trailing anchor to
    ///   another item's x anchor.
    @inlinable
    public static func trailing(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: XAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .trailing,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's centerX anchor to
    /// another item's x anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `centerX` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's centerX anchor to
    ///   another item's x anchor.
    @inlinable
    public static func centerX(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: XAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .centerX,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's centerY anchor to
    /// another item's y anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `centerY` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's centerY anchor to
    ///   another item's y anchor.
    @inlinable
    public static func centerY(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: YAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .centerY,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's top anchor to
    /// another item's y anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `top` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's top anchor to
    ///   another item's y anchor.
    @inlinable
    public static func top(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: YAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .top,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's bottom anchor to
    /// another item's y anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `bottom` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's bottom anchor to
    ///   another item's y anchor.
    @inlinable
    public static func bottom(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: YAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .bottom,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's firstBaseline anchor
    /// to another item's y anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `firstBaseline` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's firstBaseline
    ///   anchor to another item's y anchor.
    @inlinable
    public static func firstBaseline(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: YAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .firstBaseline,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's lastBaseline anchor
    /// to another item's y anchor.
    ///
    /// - Parameters:
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `lastBaseline` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's lastBaseline
    ///   anchor to another item's y anchor.
    @inlinable
    public static func lastBaseline(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: YAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .lastBaseline,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for applying a fixed width to an item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed width to an
    ///   item.
    @inlinable
    public static func fixedWidth(
        _ relation: Relation,
        _ constant: CGFloat,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .width,
                relation: relation,
                secondAttribute: .notAnAttribute,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for applying a fixed width to an item.
    ///
    /// - Parameters:
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed width to an
    ///   item.
    @inlinable
    public static func fixedWidth(
        _ constant: CGFloat,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .fixedWidth(.equal, constant, file: file, line: line)
    }

    /// Returns a `ConstraintGroup` for applying a fixed height to an item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed height to an
    ///   item.
    @inlinable
    public static func fixedHeight(
        _ relation: Relation,
        _ constant: CGFloat,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .height,
                relation: relation,
                secondAttribute: .notAnAttribute,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for applying a fixed height to an item.
    ///
    /// - Parameters:
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed height to an
    ///   item.
    @inlinable
    public static func fixedHeight(
        _ constant: CGFloat,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .fixedHeight(.equal, constant, file: file, line: line)
    }

    /// Returns a `ConstraintGroup` for applying a relative width in relation to
    /// another item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
    ///   - secondAttribute: The dimension of the second item; defaults to
    ///     `width` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a relative width in relation
    ///   to another item.
    @inlinable
    public static func relativeWidth(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: DimensionAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .width,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Returns a `ConstraintGroup` for applying a relative height in relation to
    /// another item.
    ///
    /// - Parameters:
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
    ///   - secondAttribute: The dimension of the second item; defaults to
    ///     `height` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a relative height in
    ///   relation to another item.
    @inlinable
    public static func relativeHeight(
        _ relation: Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: DimensionAttribute? = nil,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            spec:
            constraintGenerator(
                firstAttribute: .height,
                relation: relation,
                secondItem: secondItem,
                secondAttribute: secondAttribute?.attribute,
                multiplier: multiplier,
                constant: constant,
                file: file,
                line: line
            )
        )
    }

    /// Creates `NSLayoutConstraints` for the receiver's specs, using the given
    /// item as each constraint's `firstItem`.
    ///
    /// - Parameter firstItem: The `firstItem` of the constraints.
    /// - Returns: An array of `NSLayoutConstraint`.
    @inlinable
    public func constraints(with firstItem: ConstrainableItem) -> [NSLayoutConstraint] {
        return specs.map { spec in
            let constraint = spec(firstItem)
            constraint.priority = priority
            constraint.identifier = identifier
            if constraint.identifier == nil, ConstraintGroup.debugConstraints {
                constraint.identifier = "\(URL(fileURLWithPath: file.description).lastPathComponent)::\(line)"
            }
            return constraint
        }
    }
}
