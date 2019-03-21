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

/// This protocol defines an item that constraints can be applied to.
/// - Note: Only `UIView` and `UILayoutGuide` should implement this protocol.
public protocol ConstrainableItem {

    /// - Returns: The `UIView`'s `superview` or the `UILayoutGuide`'s
    /// `owningView`.
    var parentView: UIView? { get }

    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` for
    /// `UIView`s. It does nothing for `UILayoutGuide`s.
    func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()

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
}

extension ConstrainableItem {

    @usableFromInline
    func makeConstraints<S>(groups: S) -> [NSLayoutConstraint] where S: Sequence, S.Element == ConstraintGroup {
        setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
        return groups.reduce(into: .init()) { result, group in
            switch group.specs {
            case .single(let spec):
                let constraint = spec(self)
                constraint.priority = group.priority
                constraint.identifier = group.identifier
                result.append(constraint)
            case .multiple(let specs):
                let constraints = specs(self)
                constraints.forEach { constraint in
                    constraint.priority = group.priority
                    constraint.identifier = group.identifier
                }
                result += constraints
            }
        }
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
    public func makeConstraints(_ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        return makeConstraints(groups: groups)
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
    public func applyConstraints(_ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        let constraints = makeConstraints(groups: groups)
        constraints.activate()
        return constraints
    }
}

// MARK: - Implementations

extension UIView: ConstrainableItem {

    /// Returns the receiver's `superview`.
    public var parentView: UIView? {
        return superview
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
        return owningView
    }

    /// This does nothing on `UILayoutGuide`s.
    public func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {

    }

    /// Returns the receiver's `topAnchor`.
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        return topAnchor
    }

    /// Returns the receiver's `bottomAnchor`.
    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        return bottomAnchor
    }
}
