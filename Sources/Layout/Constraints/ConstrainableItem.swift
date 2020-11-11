import UIKit

/// This protocol defines an item that constraints can be applied to.
/// - Note: Only `UIView` and `UILayoutGuide` should implement this protocol.
public protocol ConstrainableItem: AnyObject {
    /// - Returns: The `UIView`'s `superview` or the `UILayoutGuide`'s
    /// `owningView`.
    var parentView: UIView? { get }

    /// The item's left anchor.
    var leftAnchor: NSLayoutXAxisAnchor { get }

    /// The item's right anchor.
    var rightAnchor: NSLayoutXAxisAnchor { get }

    /// The item's leading anchor.
    var leadingAnchor: NSLayoutXAxisAnchor { get }

    /// The item's trailing anchor.
    var trailingAnchor: NSLayoutXAxisAnchor { get }

    /// The item's top anchor.
    var topAnchor: NSLayoutYAxisAnchor { get }

    /// The item's bottom anchor.
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    /// The item's width anchor.
    var widthAnchor: NSLayoutDimension { get }

    /// The item's height anchor.
    var heightAnchor: NSLayoutDimension { get }

    /// The item's centerX anchor.
    var centerXAnchor: NSLayoutXAxisAnchor { get }

    /// The item's centerY anchor.
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    /// The item's firstBaselineAnchor.
    ///
    /// - Note: This will be the `topAnchor` for `UILayoutGuide`s which do not
    ///   natively have this property.
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }

    /// The item's lastBaselineAnchor.
    ///
    /// - Note: This will be the `bottom` for `UILayoutGuide`s which do not
    ///   natively have this property.
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }

    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` for
    /// `UIView`s. It does nothing for `UILayoutGuide`s.
    func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
}

private var constrainableItemToItemKey: UInt8 = 0

internal extension ConstrainableItem {
    var toItem: ConstrainableItem? {
        get {
            objc_getAssociatedObject(self, &constrainableItemToItemKey) as? ConstrainableItem
        }
        set {
            objc_setAssociatedObject(self, &constrainableItemToItemKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension ConstrainableItem {
    @usableFromInline
    func makeConstraints<S>(groups: S) -> [NSLayoutConstraint] where S: Sequence, S.Element == ConstraintGroup {
        setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
        let constraints = groups.flatMap { $0.constraints(with: self) }
        if let container = _globalConstraintContainer {
            container.addConstraints(constraints)
        }
        return constraints
    }

    /// Creates and returns an array of `NSLayoutConstraint`s corresponding to
    /// the given groups.
    ///
    /// - Parameter groups: The groups of constraints you'd like.
    /// - Returns: The `NSLayoutConstraint`s corresponding to the given
    ///   `ConstraintGroup`s.
    ///
    /// - Note: This method will call
    ///   `setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()` on
    ///   the receiver automatically.
    @inlinable
    @discardableResult
    public func makeConstraints(_ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        makeConstraints(groups: groups)
    }

    /// Creates, immediately activates, and returns an array of
    /// `NSLayoutConstraint`s corresponding to the given groups.
    ///
    /// - Parameter groups: The groups of constraints you'd like.
    /// - Returns: The `NSLayoutConstraint`s corresponding to the given
    ///   `ConstraintGroup`s.
    ///
    /// - Note: This method will call
    ///   `setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()` on
    ///    the receiver automatically.
    @inlinable
    @discardableResult
    public func applyConstraints(file: StaticString = #file, line: UInt = #line, _ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        guard _globalConstraintContainer == nil else {
            FatalError.crash("Call makeConstraints, not applyConstraints, when configurationg a DynamicLayout.", file, line)
            return []
        }
        let constraints = makeConstraints(groups: groups)
        constraints.activate()
        return constraints
    }
}

// MARK: - Implementations

extension UIView: ConstrainableItem {
    /// Returns the receiver's `superview`.
    public var parentView: UIView? {
        superview
    }

    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` on the
    /// receiver.
    public func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILayoutGuide: ConstrainableItem {
    /// Returns the receiver's `owningView`.
    public var parentView: UIView? {
        owningView
    }

    /// Returns the receiver's `topAnchor`.
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        topAnchor
    }

    /// Returns the receiver's `bottomAnchor`.
    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    /// This does nothing on `UILayoutGuide`s.
    public func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {}
}
