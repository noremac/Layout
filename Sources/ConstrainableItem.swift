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

    /// This is used when creating constraints relative to an item's parent view.
    ///
    /// - Returns: The `UIView`'s `superview` or the `UILayoutGuide`'s `owningView`.
    /// - Throws: `NoParentViewError` if the item is not yet in the view hierarchy.
    func parentView() throws -> UIView

    /// Sets `translatesAutoresizingMaskIntoConstraints` to `false` for `UIView`s.
    /// It does nothing for `UILayoutGuide`s.
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

    // TODO: document
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }

    // TODO: document
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }

    // TODO: document
    var layoutMarginsGuide: UILayoutGuide { get }
}

extension ConstrainableItem {

    func makeConstraints(groups: [ConstraintGroup]) -> [NSLayoutConstraint] {
        setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()
        return groups.flatMap { $0.constraints(withItem: self) }
    }

    /// Creates and returns an array of `NSLayoutConstraint`s corresponding to the given groups.
    ///
    /// - Parameter groups: The groups of constraints you'd like.
    /// - Returns: The `NSLayoutConstraint`s corresponding to the given `ConstraintGroup`s.
    /// - Note: This method will call `setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()` on the receiver automatically.
    public func makeConstraints(_ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        return makeConstraints(groups: groups)
    }

    /// Creates, immediately activates, and returns an array of `NSLayoutConstraint`s corresponding to the given groups.
    ///
    /// - Parameter groups: The groups of constraints you'd like.
    /// - Returns: The `NSLayoutConstraint`s corresponding to the given `ConstraintGroup`s.
    /// - Note: This method will call `setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary()` on the receiver automatically.
    @discardableResult
    public func applyConstraints(_ groups: ConstraintGroup...) -> [NSLayoutConstraint] {
        let constraints = makeConstraints(groups: groups)
        constraints.activate()
        return constraints
    }
}
