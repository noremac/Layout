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
