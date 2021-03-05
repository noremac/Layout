import UIKit

public extension UIStackView {
    private convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat,
        isLayoutMarginsRelativeArrangement: Bool,
        directionalLayoutMargins: NSDirectionalEdgeInsets?,
        isBaselineRelativeArrangement: Bool,
        arrangedSubviews: [UIView]
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        if let directionalLayoutMargins = directionalLayoutMargins {
            self.directionalLayoutMargins = directionalLayoutMargins
        }
        self.isBaselineRelativeArrangement = isBaselineRelativeArrangement

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
        isLayoutMarginsRelativeArrangement: Bool = false,
        directionalLayoutMargins: NSDirectionalEdgeInsets? = nil,
        @ArrayBuilder <UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }
        return UIStackView(
            axis: .horizontal,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            isLayoutMarginsRelativeArrangement: isLayoutMarginsRelativeArrangement,
            directionalLayoutMargins: directionalLayoutMargins,
            isBaselineRelativeArrangement: false,
            arrangedSubviews: arrangedSubviews()
        )
    }

    static func vertical(
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat = UIStackView.spacingUseDefault,
        isLayoutMarginsRelativeArrangement: Bool = false,
        directionalLayoutMargins: NSDirectionalEdgeInsets? = nil,
        isBaselineRelativeArrangement: Bool = false,
        @ArrayBuilder <UIView> arrangedSubviews: () -> [UIView]
    ) -> UIStackView {
        let previous = allowAdditionalConstraints
        allowAdditionalConstraints = true
        defer { allowAdditionalConstraints = previous }
        return UIStackView(
            axis: .vertical,
            distribution: distribution,
            alignment: alignment,
            spacing: spacing,
            isLayoutMarginsRelativeArrangement: isLayoutMarginsRelativeArrangement,
            directionalLayoutMargins: directionalLayoutMargins,
            isBaselineRelativeArrangement: isBaselineRelativeArrangement,
            arrangedSubviews: arrangedSubviews()
        )
    }
}
