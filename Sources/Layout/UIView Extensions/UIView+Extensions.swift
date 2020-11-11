import UIKit

public extension UIView {
    @discardableResult
    func contentCompressionResistanceAndHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .horizontal)
        setContentHuggingPriority(priority, for: .vertical)
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func contentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func verticalContentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        return self
    }

    @discardableResult
    func horizontalContentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func contentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .vertical)
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func verticalContentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .vertical)
        return self
    }

    @discardableResult
    func horizontalContentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func addAsSubview(to parentView: UIView) -> Self {
        parentView.addSubview(self)
        return self
    }

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

extension UIView {
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

extension UILayoutGuide {
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
