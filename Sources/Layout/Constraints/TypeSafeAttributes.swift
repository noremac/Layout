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

/// A wrapper around the "x" `NSLayoutConstraint.Attribute`s.
public struct XAttribute {
    /// The associated attribute.
    public let attribute: NSLayoutConstraint.Attribute

    /// A closure that returns the anchor logically associated with this
    /// attribute.
    public let anchor: (ConstrainableItem) -> NSLayoutXAxisAnchor

    /// Initializes an `XAttribute`.
    ///
    /// - Parameters:
    ///   - attribute: The associated attribute.
    ///   - anchor: The associated anchor.
    public init(_ attribute: NSLayoutConstraint.Attribute, _ anchor: @escaping (ConstrainableItem) -> NSLayoutXAxisAnchor) {
        self.attribute = attribute
        self.anchor = anchor
    }
}

extension XAttribute {
    /// An `XAttribute` representing `left`.
    public static let left = XAttribute(.left, { $0.leftAnchor })

    /// An `XAttribute` representing `right`.
    public static let right = XAttribute(.right, { $0.rightAnchor })

    /// An `XAttribute` representing `leading`.
    public static let leading = XAttribute(.leading, { $0.leadingAnchor })

    /// An `XAttribute` representing `trailing`.
    public static let trailing = XAttribute(.trailing, { $0.trailingAnchor })

    /// An `XAttribute` representing `centerX`.
    public static let centerX = XAttribute(.centerX, { $0.centerXAnchor })
}

/// A wrapper around the "y" `NSLayoutConstraint.Attribute`s.
public struct YAttribute {
    /// The associated attribute.
    public let attribute: NSLayoutConstraint.Attribute

    /// A closure that returns the anchor logically associated with this
    /// attribute.
    public let anchor: (ConstrainableItem) -> NSLayoutYAxisAnchor

    /// Initializes a `YAttribute`.
    ///
    /// - Parameters:
    ///   - attribute: The associated attribute.
    ///   - anchor: The associated anchor.
    public init(_ attribute: NSLayoutConstraint.Attribute, _ anchor: @escaping (ConstrainableItem) -> NSLayoutYAxisAnchor) {
        self.attribute = attribute
        self.anchor = anchor
    }
}

extension YAttribute {
    /// A `YAttribute` representing `top`.
    public static let top = YAttribute(.top, { $0.topAnchor })

    /// A `YAttribute` representing `bottom`.
    public static let bottom = YAttribute(.bottom, { $0.bottomAnchor })

    /// A `YAttribute` representing `firstBaseline`.
    public static let firstBaseline = YAttribute(.firstBaseline, { $0.firstBaselineAnchor })

    /// A `YAttribute` representing `lastBaseline`.
    public static let lastBaseline = YAttribute(.lastBaseline, { $0.lastBaselineAnchor })

    /// A `YAttribute` representing `centerY`.
    public static let centerY = YAttribute(.centerY, { $0.centerYAnchor })
}

/// A wrapper around the "dimension" `NSLayoutConstraint.Attribute`s.
public struct DimensionAttribute {
    /// The associated attribute.
    public let attribute: NSLayoutConstraint.Attribute

    /// A closure that returns the anchor logically associated with this
    /// attribute.
    public let anchor: (ConstrainableItem) -> NSLayoutDimension

    /// Initializes a `DimensionAttribute`.
    ///
    /// - Parameters:
    ///   - attribute: The associated attribute.
    ///   - anchor: The associated anchor.
    public init(_ attribute: NSLayoutConstraint.Attribute, _ anchor: @escaping (ConstrainableItem) -> NSLayoutDimension) {
        self.attribute = attribute
        self.anchor = anchor
    }
}

extension DimensionAttribute {
    /// A `DimensionAttribute` representing `width`.
    public static let width = DimensionAttribute(.width, { $0.widthAnchor })

    /// A `DimensionAttribute` representing `height`.
    public static let height = DimensionAttribute(.height, { $0.heightAnchor })
}
