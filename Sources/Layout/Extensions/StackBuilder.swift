import UIKit

public extension UIStackView {
    public static func layoutBased(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat,
        arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }

        let arrangedSubviews = arrangedSubviews()
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.axis = axis
        stack.distribution = distribution
        stack.alignment = alignment
        stack.spacing = spacing

        arrangedSubviews.flatMap { view -> [NSLayoutConstraint] in
            if let spacing = view._spacingAfter {
                stack.setCustomSpacing(spacing, after: view)
            }

            if let groups = view._additionalConstraints {
                return view.makeConstraints(groups: groups)
            } else {
                return []
            }
        }
        .activate()

        return stack
    }

    static func horizontal(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = UIStackView.spacingUseDefault,
        @ArrayBuilder <UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        return UIStackView.layoutBased(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            arrangedSubviews: arrangedSubviews
        )
    }

    static func vertical(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = UIStackView.spacingUseDefault,
        @ArrayBuilder <UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        return UIStackView.layoutBased(
            axis: .vertical,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            arrangedSubviews: arrangedSubviews
        )
    }
}
