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

public extension UIView {
    static func build(@ArrayBuilder<ConstrainableItem> items: () -> [ConstrainableItem]) -> UIView {
        let superview = UIView()
        items().flatMap { item -> [NSLayoutConstraint] in
            if let view = item as? UIView {
                superview.addSubview(view)
                if let groups = view._additionalConstraints {
                    return view.makeConstraints(groups: groups)
                } else {
                    return []
                }
            } else if let guide = item as? UILayoutGuide {
                superview.addLayoutGuide(guide)
                if let groups = guide._additionalConstraints {
                    return guide.makeConstraints(groups: groups)
                } else {
                    return []
                }
            } else {
                fatalError("Unknown item type: \(type(of: item))")
            }
        }
        .activate()
        return superview
    }
}

public extension UILayoutGuide {
    static func build(@ArrayBuilder<ConstrainableItem> items: () -> [ConstrainableItem]) -> UILayoutGuide {
        GuideBuilder(constrainableItems: items())
    }
}

private final class GuideBuilder: UILayoutGuide {
    var constrainableItems: [ConstrainableItem]

    init(constrainableItems: [ConstrainableItem]) {
        self.constrainableItems = constrainableItems
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var owningView: UIView? {
        didSet {
            if let view = owningView {
                configure(withOwningView: view)
            }
        }
    }

    private func configure(withOwningView superview: UIView) {
        constrainableItems.flatMap { item -> [NSLayoutConstraint] in
            item.toItem = self
            defer { item.toItem = nil }
            if let view = item as? UIView {
                superview.addSubview(view)
                if let groups = view._additionalConstraints {
                    return view.makeConstraints(groups: groups)
                } else {
                    return []
                }
            } else if let guide = item as? UILayoutGuide {
                superview.addLayoutGuide(guide)
                if let groups = guide._additionalConstraints {
                    return guide.makeConstraints(groups: groups)
                } else {
                    return []
                }
            } else {
                fatalError("Unknown item type: \(type(of: item))")
            }
        }
        .activate()
        constrainableItems.removeAll()
    }
}

public extension UIStackView {
    private convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat,
        arrangedSubviews: [UIView]
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing

        arrangedSubviews.flatMap { view -> [NSLayoutConstraint] in
            if let groups = view._additionalConstraints {
                return view.makeConstraints(groups: groups)
            } else {
                return []
            }
        }.activate()

        for view in arrangedSubviews {
            if let spacing = view._spacingAfter {
                setCustomSpacing(spacing, after: view)
            }
        }
    }

    static func horizontal(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = UIStackView.spacingUseDefault,
        @ArrayBuilder<UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        UIStackView(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            arrangedSubviews: arrangedSubviews()
        )
    }

    static func vertical(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = UIStackView.spacingUseDefault,
        @ArrayBuilder<UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        UIStackView(
            axis: .vertical,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            arrangedSubviews: arrangedSubviews()
        )
    }
}

public extension UIView {
    func constraints(_ constraints: ConstraintGroup...) -> Self {
        _additionalConstraints = constraints
        return self
    }

    func spacingAfter(_ spacing: CGFloat) -> Self {
        _spacingAfter = spacing
        return self
    }
}

public extension UILayoutGuide {
    func constraints(_ constraints: ConstraintGroup...) -> Self {
        _additionalConstraints = constraints
        return self
    }
}

private extension UIView {
    static var _additionalConstraintsKey: UInt8 = 0

    static var _spacingAfterKey: UInt8 = 0

    var _additionalConstraints: [ConstraintGroup]? {
        get {
            objc_getAssociatedObject(self, &Self._additionalConstraintsKey) as? [ConstraintGroup]
        }
        set {
            objc_setAssociatedObject(self, &Self._additionalConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var _spacingAfter: CGFloat? {
        get {
            objc_getAssociatedObject(self, &Self._spacingAfterKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &Self._spacingAfterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

private extension UILayoutGuide {
    static var _additionalConstraintsKey: UInt8 = 0

    var _additionalConstraints: [ConstraintGroup]? {
        get {
            objc_getAssociatedObject(self, &Self._additionalConstraintsKey) as? [ConstraintGroup]
        }
        set {
            objc_setAssociatedObject(self, &Self._additionalConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

@_functionBuilder
public enum ArrayBuilder<Element> {
    public typealias Expression = Element

    public typealias Component = [Element]

    public static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    public static func buildExpression(_ expression: Expression?) -> Component {
        expression.map({ [$0] }) ?? []
    }

    public static func buildBlock(_ children: Component...) -> Component {
        children.flatMap({ $0 })
    }

    public static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    public static func buildBlock(_ component: Component) -> Component {
        component
    }

    public static func buildEither(first child: Component) -> Component {
        child
    }

    public static func buildEither(second child: Component) -> Component {
        child
    }
}
