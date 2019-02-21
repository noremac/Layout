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

    /// When this is `true` a string with this format: `"\(file)::\(function)::\(line)"` is automatically added as each constraint's `identifier`.
    public static var debugConstraints = true

    /// The `ConstraintSpec`s.
    public var specs: [ConstraintSpec]

    /// The priority of this group of constraints.
    public var priority: UILayoutPriority = .required

    /// The identifier of this group of constraints.
    /// - SeeAlso: `ConstraintGroup.debugConstraints`.
    public var identifier: String?

    /// Creates a `ConstraintGroup` with a single spec.
    ///
    /// - Parameter spec: A `ConstraintSpec` for creating a single constraint.
    public init(spec: @escaping ConstraintSpec) {
        self.specs = [spec]
    }

    /// Creates a `ConstraintGroup` composed of other `ConstraintGroup`s.
    ///
    /// - Parameter groups: An array of `ConstraintGroup`s to concatenate together.
    public init(composedOf groups: [ConstraintGroup]) {
        self.specs = groups.flatMap { $0.specs }
    }

    /// Creates an array of `NSLayoutConstraint`s from the current group using the given item as each `NSLayoutConstraint`'s `firstItem`.
    ///
    /// - Parameter item: The `NSLayoutConstraint`'s
    /// - Returns: An array of `NSLayoutConstraint`s.
    public func constraints(withItem item: ConstrainableItem) -> [NSLayoutConstraint] {
        return specs.map { spec in
            let constraint = spec(item)
            constraint.priority = priority
            constraint.identifier = identifier
            return constraint
        }
    }

    /// This is the base method for `ConstraintGroup` creation; all other methods funnel through here.
    /// The initializers should not be used manually.
    ///
    /// - Parameters:
    ///   - spec: A close that takes a `ConstrainableItem` and returns an `NSLayoutConstraint`.
    /// - Returns: A `ConstraintGroup` wrapping the given spec.
    public static func with(
        _ spec: @escaping ConstraintSpec,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        var group = ConstraintGroup(spec: spec)
        if debugConstraints {
            group.identifier = "\(file)::\(function)::\(line)"
        }
        return group
    }

    /// Returns a `ConstraintGroup` for aligning an item's x anchor to another item's x anchor.
    ///
    /// - Parameters:
    ///   - firstAttr: The desired `XAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondAttr: The second `XAttribute`; defaults to `firstAttr` if left as `nil`.
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - offset: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's x anchor to another item's x anchor.
    public static func align(
        _ firstAttr: XAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: XAttribute? = nil,
        of item: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return with(
            constraintGenerator(
                attribute1: firstAttr.attribute,
                relation: relation,
                item2: item.map { .other($0) } ?? .parent,
                attribute2: (secondAttr ?? firstAttr).attribute,
                multiplier: multiplier,
                constant: offset
            ),
            file: file,
            function: function,
            line: line
        )
    }

    /// Returns a `ConstraintGroup` for aligning an item's y anchor to another item's y anchor.
    ///
    /// - Parameters:
    ///   - firstAttr: The desired `YAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondAttr: The second `YAttribute`; defaults to `firstAttr` if left as `nil`.
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - offset: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's y anchor to another item's y anchor.
    public static func align(
        _ firstAttr: YAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: YAttribute? = nil,
        of item: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        ) -> ConstraintGroup {
        return with(
            constraintGenerator(
                attribute1: firstAttr.attribute,
                relation: relation,
                item2: item.map { .other($0) } ?? .parent,
                attribute2: (secondAttr ?? firstAttr).attribute,
                multiplier: multiplier,
                constant: offset
            ),
            file: file,
            function: function,
            line: line
        )
    }

    /// Returns a `ConstraintGroup` for applying a fixed dimension to an item.
    ///
    /// - Parameters:
    ///   - firstAttr: The dimension, either `.width` or `.height`
    ///   - relation: The relation; defaults to `.equal`.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed dimension to an item.
    public static func setFixed
        (
        _ firstAttr: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to constant: CGFloat,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        )
        -> ConstraintGroup {
            return with(
                constraintGenerator(
                    attribute1: firstAttr.attribute,
                    relation: relation,
                    item2: nil,
                    attribute2: .notAnAttribute,
                    multiplier: 1,
                    constant: constant
                ),
                file: file,
                function: function,
                line: line
            )
    }

    /// Returns a `ConstraintGroup` for applying a relative dimension in relation to another item.
    ///
    /// - Parameters:
    ///   - firstAttr: The dimension, either `.width` or `.height`
    ///   - relation: The relation; defaults to `.equal`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - item: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - secondAttr: The dimension of the second item; defaults to `firstAttr` if left as `nil`.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a relative dimension in relation to another item.
    public static func setRelative
        (
        _ firstAttr: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to multiplier: CGFloat = 1,
        of item: ConstrainableItem? = nil,
        attribute secondAttr: DimensionAttribute? = nil,
        constant: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: Int = #line
        )
        -> ConstraintGroup {
            return with(
                constraintGenerator(
                    attribute1: firstAttr.attribute,
                    relation: relation,
                    item2: item.map { .other($0) } ?? .parent,
                    attribute2: (secondAttr ?? firstAttr).attribute,
                    multiplier: multiplier,
                    constant: constant
                ),
                file: file,
                function: function,
                line: line
            )
    }
}
