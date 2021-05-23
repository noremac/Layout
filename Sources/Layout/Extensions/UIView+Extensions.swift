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

    func spacingAfter(_ spacing: CGFloat) -> Self {
        _spacingAfter = spacing
        return self
    }
}

var allowAdditionalConstraints = false

private var _additionalConstraintsKey: UInt8 = 0

extension ConstrainableItem {
    var _additionalConstraints: [MultipleConstraintGenerator]? {
        get {
            objc_getAssociatedObject(self, &_additionalConstraintsKey) as? [MultipleConstraintGenerator]
        }
        set {
            objc_setAssociatedObject(self, &_additionalConstraintsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func constraints(@ArrayBuilder <MultipleConstraintGenerator> _ constraints: () -> [MultipleConstraintGenerator]) -> Self {
        guard allowAdditionalConstraints else {
            FatalError.crash("\(#function) is only allowed when using the layout DSL.")
            return self
        }
        _additionalConstraints = constraints()
        return self
    }
}

extension UIView {
    static var _spacingAfterKey: UInt8 = 0

    var _spacingAfter: CGFloat? {
        get {
            objc_getAssociatedObject(self, &Self._spacingAfterKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &Self._spacingAfterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
