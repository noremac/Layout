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
public struct XAttribute {

    public let attribute: NSLayoutConstraint.Attribute

    public let anchor: (ConstrainableItem) -> NSLayoutXAxisAnchor

    public init(_ attribute: NSLayoutConstraint.Attribute, _ anchor: @escaping (ConstrainableItem) -> NSLayoutXAxisAnchor) {
        self.attribute = attribute
        self.anchor = anchor
    }

    public static let left = XAttribute(.left, { $0.leftAnchor })
    public static let right = XAttribute(.right, { $0.rightAnchor })
    public static let leading = XAttribute(.leading, { $0.leadingAnchor })
    public static let trailing = XAttribute(.trailing, { $0.trailingAnchor })
    public static let centerX = XAttribute(.centerX, { $0.centerXAnchor })
}

/// A wrapper around the "y" `NSLayoutConstraint.Attribute`s.
public struct YAttribute {

    public let attribute: NSLayoutConstraint.Attribute

    public let anchor: (ConstrainableItem) -> NSLayoutYAxisAnchor

    public init(_ attribute: NSLayoutConstraint.Attribute, _ anchor: @escaping (ConstrainableItem) -> NSLayoutYAxisAnchor) {
        self.attribute = attribute
        self.anchor = anchor
    }

    public static let top = YAttribute(.top, { $0.topAnchor })
    public static let bottom = YAttribute(.bottom, { $0.bottomAnchor })
    public static let firstBaseline = YAttribute(.firstBaseline, { $0.firstBaselineAnchor })
    public static let lastBaseline = YAttribute(.lastBaseline, { $0.lastBaselineAnchor })
    public static let centerY = YAttribute(.centerY, { $0.centerYAnchor })
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
