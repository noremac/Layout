/*
 The MIT License (MIT)

 Copyright (c) 2020 Cameron Pulsford

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

/// A closure that takes a `ConstrainableItem` and returns an
/// `NSLayoutConstraint`.
public typealias ConstraintSpec = (ConstrainableItem) -> NSLayoutConstraint

@usableFromInline
func constraintGenerator(
    firstAttribute: NSLayoutConstraint.Attribute,
    relation: ConstraintGroup.Relation,
    secondItem: ConstrainableItem? = nil,
    secondAttribute: NSLayoutConstraint.Attribute?,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: StaticString,
    line: UInt
) -> ConstraintSpec {
    // swiftformat:disable redundantReturn
    return { firstItem in
        let toItem: ConstrainableItem?
        if secondAttribute == .notAnAttribute {
            toItem = nil
        } else {
            if let item = secondItem ?? firstItem.parentView {
                toItem = item
            } else {
                FatalError.crash("To automatically relate your constraints to the parent view, your item must already be a part of the view hierarchy.", file, line)
                // Return nonsense, will only be executed in tests.
                return NSLayoutConstraint(item: firstItem, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            }
        }
        return NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation.constraintRelation,
            toItem: toItem,
            attribute: secondAttribute ?? firstAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
}
