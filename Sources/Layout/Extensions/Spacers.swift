import UIKit

public final class HorizontalSpacer: UIView {
    private let minimumLength: CGFloat

    public init(minimumLength: CGFloat = 0, file: String = #file, line: UInt = #line) {
        self.minimumLength = minimumLength
        super.init(frame: .zero)
        setContentHuggingPriority(.init(1), for: .horizontal)
        setContentCompressionResistancePriority(.init(1), for: .horizontal)
        applyConstraints {
            Width(minimumLength, file: file, line: line) ~ .defaultLow
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        CGSize(width: 8000, height: UIView.noIntrinsicMetric)
    }
}

public final class VerticalSpacer: UIView {
    private let minimumLength: CGFloat

    public init(minimumLength: CGFloat = 0, file: String = #file, line: UInt = #line) {
        self.minimumLength = minimumLength
        super.init(frame: .zero)
        setContentHuggingPriority(.init(1), for: .vertical)
        setContentCompressionResistancePriority(.init(1), for: .vertical)
        applyConstraints {
            Height(minimumLength, file: file, line: line) ~ .defaultLow
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 8000)
    }
}
