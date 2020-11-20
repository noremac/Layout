import UIKit

/// This protocol defines an item that constraints can be applied to.
/// - Note: Only `UIView` and `UILayoutGuide` should implement this protocol.
public protocol ConstrainableItem: AnyObject {
    /// - Returns: The `UIView`'s `superview` or the `UILayoutGuide`'s
    /// `owningView`.
    var parentView: UIView? { get }

    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` for
    /// `UIView`s. It does nothing for `UILayoutGuide`s.
    func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
}

public extension ConstrainableItem {
    @inlinable
    func makeConstraints(groups: [MultipleConstraintGenerator]) -> [NSLayoutConstraint] {
        setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
        let constraints = groups.reduce(into: [NSLayoutConstraint]()) { acc, generator in
            generator.insertConstraints(withItem: self, into: &acc)
        }
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
    func makeConstraints(@ArrayBuilder <MultipleConstraintGenerator> _ groups: () -> [MultipleConstraintGenerator]) -> [NSLayoutConstraint] {
        makeConstraints(groups: groups())
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
    func applyConstraints(file: StaticString = #file, line: UInt = #line, @ArrayBuilder <MultipleConstraintGenerator> _ groups: () -> [MultipleConstraintGenerator]) -> [NSLayoutConstraint] {
        guard _globalConstraintContainer == nil else {
            FatalError.crash("Call makeConstraints, not applyConstraints, when configurationg a DynamicLayout.", file: file, line: line)
            return []
        }
        let constraints = makeConstraints(groups: groups())
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

    /// This does nothing on `UILayoutGuide`s.
    public func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {}
}

// MARK: Internal

private var constrainableItemToItemKey: UInt8 = 0

extension ConstrainableItem {
    var toItem: ConstrainableItem? {
        get {
            objc_getAssociatedObject(self, &constrainableItemToItemKey) as? ConstrainableItem
        }
        set {
            objc_setAssociatedObject(self, &constrainableItemToItemKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
