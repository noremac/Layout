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

/// A wrapper around the "x" `NSLayoutConstraint.Attribute`s.
/// - Note:
/// `.left` and `.right` are purposefully elided as `.leading`
/// and `.trailing` should generally be preferred.
///
/// Additionally, `.left` / `.right` / `.leading` / `.trailing` are also
/// not safe to mix and cause crashes at run time.
///
/// If you absolutely need `.left` or `.right` use `ConstraintGroup`'s
/// `.with` method like this:
///
///     view.makeConstraints(.with({ $0.leftAnchor.constraint(equalTo....) })
public struct XAttribute {

    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }

    public static let leading = XAttribute(.leading)
    public static let trailing = XAttribute(.trailing)
    public static let leadingMargin = XAttribute(.leadingMargin)
    public static let trailingMargin = XAttribute(.trailingMargin)
    public static let centerX = XAttribute(.centerX)
    public static let centerXWithinMargins = XAttribute(.centerXWithinMargins)
}

/// A wrapper around the "y" `NSLayoutConstraint.Attribute`s.
public struct YAttribute {

    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }

    public static let top = YAttribute(.top)
    public static let bottom = YAttribute(.bottom)
    public static let topMargin = YAttribute(.topMargin)
    public static let bottomMargin = YAttribute(.bottomMargin)
    public static let firstBaseline = YAttribute(.firstBaseline)
    public static let lastBaseline = YAttribute(.lastBaseline)
    public static let centerY = YAttribute(.centerY)
    public static let centerYWithinMargins = YAttribute(.centerYWithinMargins)
}

/// A wrapper around the "dimension" `NSLayoutConstraint.Attribute`s.
public struct DimensionAttribute {

    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }

    public static let width = DimensionAttribute(.width)
    public static let height = DimensionAttribute(.height)
}
