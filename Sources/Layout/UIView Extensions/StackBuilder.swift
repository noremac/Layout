import UIKit

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
            if let spacing = view._spacingAfter {
                setCustomSpacing(spacing, after: view)
            }

            if let groups = view._additionalConstraints {
                return view.makeConstraints(groups: groups)
            } else {
                return []
            }
        }
        .activate()
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
