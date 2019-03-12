import Layout
import PlaygroundSupport
import UIKit

class Example: UIViewController {

    let expandingView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 3
        return slider
    }()

    let layout = DynamicLayout<Float>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(expandingView)
        view.addSubview(slider)

        slider.addTarget(
            self,
            action: #selector(Example.updateEnvironment),
            for: .valueChanged
        )

        layout.configure { ctx in
            ctx.addConstraints(
                slider.makeConstraints(
                    .align(.leading, of: view.layoutMarginsGuide),
                    .align(.trailing, of: view.layoutMarginsGuide),
                    .align(.bottom)
                )
            )

            ctx.addConstraints(
                expandingView.makeConstraints(
                    .center(),
                    .align(.leading, .greaterThanOrEqual, of: view.layoutMarginsGuide),
                    .align(.trailing, .lessThanOrEqual, of: view.layoutMarginsGuide),
                    .setRelative(.height, of: expandingView, attribute: .width)
                )
            )

            let width: CGFloat = 100

            let sizeConstraints = ctx.addConstraints(
                expandingView.makeConstraints(
                    .setFixed(.width, to: width) ~ .defaultHigh
                )
            )

            ctx.addAction {
                sizeConstraints.setConstant(width * (1 + CGFloat($0)))
            }
        }

        layout.update(environment: slider.value)
    }

    @objc
    private func updateEnvironment() {
        layout.update(environment: slider.value)
    }
}

let viewController = Example()

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
