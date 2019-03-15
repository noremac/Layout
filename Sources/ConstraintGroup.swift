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

    public enum Specs {
        case single(SingleConstraintSpec)
        case multiple(MultipleConstraintSpec)
    }

    /// When this is `true` a string with this format: `"\(file)::\(function)::\(line)"` is automatically added as each constraint's `identifier`.
    public static var debugConstraints = true

    /// The `MultipleConstraintSpec`s.
    public var specs: Specs

    /// The priority of this group of constraints.
    public var priority: UILayoutPriority = .required

    /// The identifier of this group of constraints.
    /// - SeeAlso: `ConstraintGroup.debugConstraints`.
    public var identifier: String?

    public init(file: StaticString = #file, function: StaticString = #function, line: UInt = #line, specs: Specs) {
        self.specs = specs
        if ConstraintGroup.debugConstraints {
            identifier = "\(URL(fileURLWithPath: file.description).lastPathComponent)::\(function)::\(line)"
        }
    }

    public init(file: StaticString = #file, function: StaticString = #function, line: UInt = #line, single: @escaping SingleConstraintSpec) {
        self.init(file: file, function: function, line: line, specs: .single(single))
    }

    public init(file: StaticString = #file, function: StaticString = #function, line: UInt = #line, multiple: @escaping MultipleConstraintSpec) {
        self.init(file: file, function: function, line: line, specs: .multiple(multiple))
    }

    /// Returns a `ConstraintGroup` for aligning an item's x anchor to another item's x anchor.
    ///
    /// - Parameters:
    ///   - firstAttr: The desired `XAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondAttr: The second `XAttribute`; defaults to `firstAttr` if left as `nil`.
    ///   - secondItem: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - offset: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's x anchor to another item's x anchor.
    public static func align(
        _ firstAttr: XAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: XAttribute? = nil,
        of secondItem: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            function: function,
            line: line,
            single: { item1 in
                constraintGenerator(
                    item1: item1,
                    attribute1: firstAttr.attribute,
                    relation: relation,
                    item2: secondItem,
                    attribute2: secondAttr?.attribute,
                    multiplier: multiplier,
                    constant: offset
                )
        })
    }

    /// Returns a `ConstraintGroup` for aligning an item's y anchor to another item's y anchor.
    ///
    /// - Parameters:
    ///   - firstAttr: The desired `YAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondAttr: The second `YAttribute`; defaults to `firstAttr` if left as `nil`.
    ///   - secondItem: The item you are making the constraint against; defaults to the `superview` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - offset: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's y anchor to another item's y anchor.
    public static func align(
        _ firstAttr: YAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondAttr: YAttribute? = nil,
        of secondItem: ConstrainableItem? = nil,
        multiplier: CGFloat = 1,
        offsetBy offset: CGFloat = 0,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            function: function,
            line: line,
            single: { item1 in
                constraintGenerator(
                    item1: item1,
                    attribute1: firstAttr.attribute,
                    relation: relation,
                    item2: secondItem,
                    attribute2: secondAttr?.attribute,
                    multiplier: multiplier,
                    constant: offset
                )
        })
    }

    /// Returns a `ConstraintGroup` for applying a fixed dimension to an item.
    ///
    /// - Parameters:
    ///   - firstAttr: The dimension, either `.width` or `.height`.
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
        line: UInt = #line
        )
        -> ConstraintGroup {
            return .init(
                file: file,
                function: function,
                line: line,
                single: { item1 in
                    constraintGenerator(item1: item1, attribute1: firstAttr.attribute, relation: relation, attribute2: .notAnAttribute, constant: constant)
            })
    }

    /// Returns a `ConstraintGroup` for applying a relative dimension in relation to another item.
    ///
    /// - Parameters:
    ///   - firstAttr: The dimension, either `.width` or `.height`.
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
        line: UInt = #line
        )
        -> ConstraintGroup {
            return .init(
                file: file,
                function: function,
                line: line,
                single: { item1 in
                    constraintGenerator(item1: item1, attribute1: firstAttr.attribute, relation: relation, item2: item, attribute2: (secondAttr ?? firstAttr).attribute, multiplier: multiplier, constant: constant)
            })
    }
}
