import UIKit

public extension UIView {
    static func build(@ArrayBuilder<ConstrainableItem> items: () -> [ConstrainableItem]) -> UIView {
        let superview = UIView()
        add(constrainableItems: items(), to: superview)
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
            if let superview = owningView, !constrainableItems.isEmpty {
                constrainableItems.forEach({ $0.toItem = self })
                add(constrainableItems: constrainableItems, to: superview)
                constrainableItems.forEach({ $0.toItem = nil })
                constrainableItems.removeAll()
            }
        }
    }
}

private func add(constrainableItems: [ConstrainableItem], to superview: UIView) {
    constrainableItems.flatMap { item -> [NSLayoutConstraint] in
        if let view = item as? UIView {
            superview.addSubview(view)
            return view._additionalConstraints.map(view.makeConstraints(groups:)) ?? []
        } else if let guide = item as? UILayoutGuide {
            superview.addLayoutGuide(guide)
            return guide._additionalConstraints.map(guide.makeConstraints(groups:)) ?? []
        } else {
            FatalError.crash("Unknown item type: \(type(of: item))", #file, #line)
            return []
        }
    }
    .activate()
}
