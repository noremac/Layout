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

/// A closure that takes a `ConstrainableItem` and returns an `NSLayoutConstraint`.
public typealias SingleConstraintSpec = (ConstrainableItem) -> NSLayoutConstraint

/// A closure that takes a `ConstrainableItem` and returns an `[NSLayoutConstraint]`.
public typealias MultipleConstraintSpec = (ConstrainableItem) -> [NSLayoutConstraint]

func constraintGenerator(
    item1: ConstrainableItem,
    attribute1: NSLayoutConstraint.Attribute,
    relation: NSLayoutConstraint.Relation = .equal,
    item2: ConstrainableItem? = nil,
    attribute2: NSLayoutConstraint.Attribute? = nil,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0,
    file: StaticString = #file,
    line: UInt = #line
    ) -> NSLayoutConstraint {
    return NSLayoutConstraint(
        item: item1,
        attribute: attribute1,
        relatedBy: relation,
        toItem: attribute2 == .notAnAttribute
            ? nil
            : (item2 ?? item1.parentView) ?? { assertionFailure("To automatically relate your constraints to the parent view, your item must already be a part of the view hierarchy.", file: file, line: line); return nil }(),
        attribute: attribute2 ?? attribute1,
        multiplier: multiplier,
        constant: constant
    )
}
