import Layout
import PlaygroundSupport
import UIKit

let view = UIView()
let container = UIView()
let button = UIButton()
let otherButton = UIButton()

view.addSubview(container)
view.addSubview(button)
view.addSubview(otherButton)

// Aligning
button.makeConstraints(
    .align(.leading, .equal, to: otherButton, attribute: .leading, multiplier: 1, constant: 0),
    .align(.leading, .equal, to: otherButton, attribute: .leading, multiplier: 1),
    .align(.leading, .equal, to: otherButton, attribute: .leading),
    .align(.leading, .equal, to: otherButton),
    .align(.leading, .equal),
    .align(.leading)
)

// Align to all edges
container.makeConstraints(
    .alignToEdges(),
    .alignToEdges(of: view.safeAreaLayoutGuide),
    .alignToEdges(insets: .init(top: 10, leading: 20, bottom: 10, trailing: 20))
)

// Fixed dimensions
button.makeConstraints(
    .setFixed(.width, to: 100),
    .setFixed(.width, .greaterThanOrEqual, to: 100)
)

// Centering
button.makeConstraints(
    .center(),
    .center(in: container)
)

// Setting size
button.makeConstraints(
    .setSize(.greaterThanOrEqual, to: CGSize(width: 100, height: 100)),
    .setSize(to: CGSize(width: 100, height: 100))
)

// Relative dimensions
button.makeConstraints(
    .setRelative(.height),
    .setRelative(.height, to: otherButton),
    .setRelative(.height, to: otherButton, ratio: 0.5),
    .setRelative(.height, .lessThanOrEqual, to: otherButton),
    .setRelative(.height, .equal, to: otherButton, attribute: .width, ratio: 0.5, constant: 10)
)

// Matching size
button.makeConstraints(
    .setRelativeSize(),
    .setRelativeSize(to: otherButton),
    .setRelativeSize(to: otherButton, ratio: 0.5),
    .setRelativeSize(.lessThanOrEqual, to: otherButton)
)

// Using priority to give a button a nice chunky width, but not go outside the
// edges of the screen on narrower devices.
button.makeConstraints(
    .setFixed(.width, to: 320) ~ .defaultHigh,
    .align(.leading, .greaterThanOrEqual, to: view.readableContentGuide),
    .align(.trailing, .lessThanOrEqual, to: view.readableContentGuide)
)

class SliderExample: UIViewController {

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
            action: #selector(SliderExample.updateEnvironment),
            for: .valueChanged
        )

        layout.configure { ctx in
            ctx.addConstraints(
                slider.makeConstraints(
                    .align(.leading, to: view.layoutMarginsGuide),
                    .align(.trailing, to: view.layoutMarginsGuide),
                    .align(.bottom)
                )
            )

            ctx.addConstraints(
                expandingView.makeConstraints(
                    .center(),
                    .align(.leading, .greaterThanOrEqual, to: view.layoutMarginsGuide),
                    .align(.trailing, .lessThanOrEqual, to: view.layoutMarginsGuide),
                    .setRelative(.height, to: expandingView, attribute: .width)
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

let viewController = SliderExample()

PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
