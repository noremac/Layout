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

public typealias ConstraintSpec = (ConstrainableItem) -> NSLayoutConstraint

enum SecondItem {
    case parent
    case other(ConstrainableItem)
}

func constraintGenerator(
    attribute1: NSLayoutConstraint.Attribute,
    relation: NSLayoutConstraint.Relation,
    item2: SecondItem?,
    attribute2: NSLayoutConstraint.Attribute,
    multiplier: CGFloat,
    constant: CGFloat
    ) -> (ConstrainableItem) -> NSLayoutConstraint {
    return { item in
        let otherItem: ConstrainableItem? = {
            switch item2 {
            case .parent?:
                do {
                    return try item.parentView()
                } catch {
                    fatalError("Your \(type(of: item)) must be part of the view hierarchy. \(error)")
                }
            case .other(let other)?:
                return other
            case nil:
                return nil
            }
        }()
        return NSLayoutConstraint(
            item: item,
            attribute: attribute1,
            relatedBy: relation,
            toItem: otherItem,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant
        )
    }
}
