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
        self
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
        self
    }
}

/// A struct that implements both `DynamicLayoutTraitEnvironmentProtocol` and
/// `DynamicLayoutSizeEnvironmentProtocol`. It is useful for a
/// `UIViewController`'s `DynamicLayout.Environment`.
public struct DynamicLayoutTraitAndSizeEnvironment: DynamicLayoutTraitEnvironmentProtocol, DynamicLayoutSizeEnvironmentProtocol {
    /// The trait collection.
    public var traitCollection: UITraitCollection

    /// The size.
    public var size: CGSize

    public init(traitCollection: UITraitCollection, size: CGSize) {
        self.traitCollection = traitCollection
        self.size = size
    }
}

extension DynamicLayout where Environment: DynamicLayoutTraitEnvironmentProtocol {
    /// Configures a layout with the three most common configurations.
    ///
    /// - Parameters:
    ///   - regularHeightCompactWidth: A block for configuring constraints when
    ///   the height is regular and the width is compact.
    ///   - regularHeightRegularWidth: A block for configuring constraints when
    ///   the height is regular and the width is regular.
    ///   - compactHeight: A block for configuring constraints when the height
    ///   is compact regardless of width.
    public func configure(
        file: StaticString = #file,
        line: UInt = #line,
        regularHeightCompactWidth: (_ ctx: inout Context) -> Void,
        regularHeightRegularWidth: (_ ctx: inout Context) -> Void,
        compactHeight: (_ ctx: inout Context) -> Void
    ) {
        configure(file: file, line: line) { ctx in
            ctx.when(.verticallyRegular && .horizontallyCompact) { ctx in
                regularHeightCompactWidth(&ctx)
            }
            ctx.when(.verticallyRegular && .horizontallyRegular) { ctx in
                regularHeightRegularWidth(&ctx)
            }
            ctx.when(.verticallyCompact) { ctx in
                compactHeight(&ctx)
            }
        }
    }
}
