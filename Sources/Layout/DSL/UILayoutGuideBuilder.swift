import UIKit

public extension UILayoutGuide {
    static func build(@ArrayBuilder <ConstrainableItem> items: () -> [ConstrainableItem]) -> UILayoutGuide {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }
        return GuideBuilder(constrainableItems: items())
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
            if let superview = owningView, !constrainableItems.isEmpty {
                constrainableItems.forEach({ $0.toItem = self })
                add(constrainableItems: constrainableItems, to: superview)
                constrainableItems.forEach({ $0.toItem = nil })
                constrainableItems.removeAll()
            }
        }
    }
}
