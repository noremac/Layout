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

/// A protocol for declaring that a `DynamicLayout`'s `Environment` has a trait
/// collection property.
public protocol DynamicLayoutTraitEnvironmentProtocol {

    /// The current `UITraitCollection`.
    var traitCollection: UITraitCollection { get }
}

extension UITraitCollection: DynamicLayoutTraitEnvironmentProtocol {

    /// Returns the receiver. This exists to satisfy
    /// `DynamicLayoutTraitEnvironmentProtocol`.
    public var traitCollection: UITraitCollection {
        return self
    }
}

/// A protocol for declaring that a `DynamicLayout`'s `Environment` has a size
/// property.
public protocol DynamicLayoutSizeEnvironmentProtocol {

    ///  The current `CGSize`.
    var size: CGSize { get }
}

extension CGSize: DynamicLayoutSizeEnvironmentProtocol {

    /// Returns the receiver. This exists to satisfy
    /// `DynamicLayoutSizeEnvironmentProtocol`.
    public var size: CGSize {
        return self
    }
}

/// A struct that implements both `DynamicLayoutTraitEnvironmentProtocol` and
/// `DynamicLayoutSizeEnvironmentProtocol`. It is useful for a
/// `UIViewController`'s `DynamicLayout.Environment`.
public struct DynamicLayoutTraitAndSizeEnvironment: DynamicLayoutTraitEnvironmentProtocol, DynamicLayoutSizeEnvironmentProtocol {

    public var traitCollection: UITraitCollection

    public var size: CGSize

    public init(traitCollection: UITraitCollection, size: CGSize) {
        self.traitCollection = traitCollection
        self.size = size
    }
}
