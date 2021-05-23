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

func add(constrainableItems: [ConstrainableItem], to superview: UIView) {
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
