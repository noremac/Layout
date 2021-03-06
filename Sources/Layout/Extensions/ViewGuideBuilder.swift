import UIKit

public extension UIView {
    static func build(@ArrayBuilder <ConstrainableItem> items: () -> [ConstrainableItem]) -> UIView {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }
        let superview = UIView()
        add(constrainableItems: items(), to: superview)
        return superview
    }

    @discardableResult
    func overlay(@ArrayBuilder <ConstrainableItem> items: () -> [ConstrainableItem]) -> Self {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }
        add(constrainableItems: items(), to: self)
        return self
    }

    func padding(
        _ edges: NSDirectionalRectEdge = .all,
        insets: NSDirectionalEdgeInsets = .zero,
        file: String = #file,
        line: UInt = #line
    ) -> UIView {
        let view = UIView()
        view.addSubview(self)
        applyConstraints {
            AlignEdges(edges, insets: insets, file: file, line: line)
        }
        return view
    }
}

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

private func add(constrainableItems: [ConstrainableItem], to superview: UIView) {
    constrainableItems.flatMap { item -> [NSLayoutConstraint] in
        if let view = item as? UIView {
            superview.addSubview(view)
            return view._additionalConstraints.map(view.makeConstraints(groups:)) ?? []
        } else if let guide = item as? UILayoutGuide {
            superview.addLayoutGuide(guide)
            return guide._additionalConstraints.map(guide.makeConstraints(groups:)) ?? []
        } else {
            FatalError.crash("Unknown item type: \(type(of: item))")
            return []
        }
    }
    .activate()
}
