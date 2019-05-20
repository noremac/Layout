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

    @usableFromInline
    enum Specs {
        case single(SingleConstraintSpec)
        case multiple(MultipleConstraintSpec)
    }

    @usableFromInline let specs: Specs

    /// When this is `true` a string with this format:
    /// `"\(file)::\(line)"`is automatically added as each
    /// constraint's `identifier`.
    public static var debugConstraints = true

    /// The priority of this group of constraints.
    public var priority: UILayoutPriority = .required

    /// The identifier of this group of constraints.
    /// - SeeAlso: `ConstraintGroup.debugConstraints`.
    public var identifier: String?

    @inlinable
    init(file: StaticString, line: UInt, specs: Specs) {
        self.specs = specs
        if ConstraintGroup.debugConstraints {
            identifier = "\(URL(fileURLWithPath: file.description).lastPathComponent)::\(line)"
        }
    }

    @inlinable
    init(file: StaticString, line: UInt, single: @escaping SingleConstraintSpec) {
        self.init(file: file, line: line, specs: .single(single))
    }

    @inlinable
    init(file: StaticString, line: UInt, multiple: @escaping MultipleConstraintSpec) {
        self.init(file: file, line: line, specs: .multiple(multiple))
    }

    /// Initializes a `ConstraintGroup` composed of other `ConstraintGroup`s.
    /// Use this to build your own convenience extensions using the existing
    /// functions as building blocks.
    ///
    /// - Parameters:
    ///   - groups: The groups to compose.
    @inlinable
    public init(file: StaticString, line: UInt, composedOf groups: ConstraintGroup...) {
        let spec = Specs.multiple({ firstItem in
            groups.reduce(into: .init()) { constraints, group in
                switch group.specs {
                case .single(let spec):
                    constraints.append(spec(firstItem))
                case .multiple(let specs):
                    constraints.append(contentsOf: specs(firstItem))
                }
            }
        })
        self.init(file: file, line: line, specs: spec)
    }

    /// Returns a `ConstraintGroup` for aligning an item's x anchor to another
    /// item's x anchor.
    ///
    /// - Parameters:
    ///   - firstAttribute: The desired `XAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `XAttribute`; defaults to
    ///     `firstAttribute` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's x anchor to
    ///   another item's x anchor.
    @inlinable
    public static func align(
        _ firstAttribute: XAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
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
            single: { firstItem in
                constraintGenerator(
                    firstItem: firstItem,
                    firstAttribute: firstAttribute.attribute,
                    relation: relation,
                    secondItem: secondItem,
                    secondAttribute: secondAttribute?.attribute,
                    multiplier: multiplier,
                    constant: constant,
                    file: file,
                    line: line
                )
        })
    }

    /// Returns a `ConstraintGroup` for aligning an item's y anchor to another
    /// item's y anchor.
    ///
    /// - Parameters:
    ///   - firstAttribute: The desired `YAttribute`.
    ///   - relation: A layout relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults
    ///     to the `superview` if left as `nil`.
    ///   - secondAttribute: The second `YAttribute`; defaults to
    ///     `firstAttribute` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant; defaults to 0.
    /// - Returns: A `ConstraintGroup` for aligning an item's y anchor to
    ///   another item's y anchor.
    @inlinable
    public static func align(
        _ firstAttribute: YAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
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
            single: { firstItem in
                constraintGenerator(
                    firstItem: firstItem,
                    firstAttribute: firstAttribute.attribute,
                    relation: relation,
                    secondItem: secondItem,
                    secondAttribute: secondAttribute?.attribute,
                    multiplier: multiplier,
                    constant: constant,
                    file: file,
                    line: line
                )
        })
    }

    /// Returns a `ConstraintGroup` for applying a fixed dimension to an item.
    ///
    /// - Parameters:
    ///   - firstAttribute: The dimension, either `.width` or `.height`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a fixed dimension to an
    ///   item.
    @inlinable
    public static func setFixed
        (
        _ firstAttribute: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to constant: CGFloat,
        file: StaticString = #file,
        line: UInt = #line
        )
        -> ConstraintGroup {
            return .init(
                file: file,
                line: line,
                single: { firstItem in
                    constraintGenerator(
                        firstItem: firstItem,
                        firstAttribute: firstAttribute.attribute,
                        relation: relation,
                        secondAttribute: .notAnAttribute,
                        constant: constant,
                        file: file,
                        line: line
                    )
            })
    }

    /// Returns a `ConstraintGroup` for applying a relative dimension in
    /// relation to another item.
    ///
    /// - Parameters:
    ///   - firstAttribute: The dimension, either `.width` or `.height`.
    ///   - relation: The relation; defaults to `.equal`.
    ///   - secondItem: The item you are making the constraint against; defaults to
    ///     the `superview` if left as `nil`.
    ///   - secondAttribute: The dimension of the second item; defaults to
    ///     `firstAttribute` if left as `nil`.
    ///   - multiplier: The multiplier; defaults to 1.
    ///   - constant: The constant.
    /// - Returns: A `ConstraintGroup` for applying a relative dimension in
    ///   relation to another item.
    @inlinable
    public static func setRelative
        (
        _ firstAttribute: DimensionAttribute,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to secondItem: ConstrainableItem? = nil,
        attribute secondAttribute: DimensionAttribute? = nil,
        ratio multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        file: StaticString = #file,
        line: UInt = #line
        )
        -> ConstraintGroup {
            return .init(
                file: file,
                line: line,
                single: { firstItem in
                    constraintGenerator(
                        firstItem: firstItem,
                        firstAttribute: firstAttribute.attribute,
                        relation: relation,
                        secondItem: secondItem,
                        secondAttribute: (secondAttribute ?? firstAttribute).attribute,
                        multiplier: multiplier,
                        constant: constant,
                        file: file,
                        line: line
                    )
            })
    }
}
