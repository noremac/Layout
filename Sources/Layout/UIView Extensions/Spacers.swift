import UIKit

public final class HorizontalSpacer: UIView {
    private let minimumLength: CGFloat

    public init(minimumLength: CGFloat = 0) {
        self.minimumLength = minimumLength
        super.init(frame: .zero)
        setContentHuggingPriority(.init(1), for: .horizontal)
        setContentCompressionResistancePriority(.init(1), for: .horizontal)
        applyConstraints(.fixedWidth(minimumLength) ~ .defaultLow)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        CGSize(width: 8000, height: UIView.noIntrinsicMetric)
    }
}

public final class VerticalSpacer: UIView {
    private let minimumLength: CGFloat

    public init(minimumLength: CGFloat = 0) {
        self.minimumLength = minimumLength
        super.init(frame: .zero)
        setContentHuggingPriority(.init(1), for: .vertical)
        setContentCompressionResistancePriority(.init(1), for: .vertical)
        applyConstraints(.fixedHeight(minimumLength) ~ .defaultLow)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 8000)
    }
}
