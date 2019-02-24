import Layout
import PlaygroundSupport
import UIKit

class Example: UIViewController {

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let image = UIGraphicsImageRenderer(bounds: rect).image(actions: { context in
            let path = UIBezierPath(rect: rect)
            UIColor.blue.setFill()
            path.fill()
        })
        button.setBackgroundImage(image, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        return button
    }()

    let center: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let red: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        view.addSubview(loginButton)
        loginButton.applyConstraints(
            .setFixed(.width, to: 400) ~ .defaultHigh,
            .setFixed(.height, to: 44),
            .align(.bottom, of: view.safeAreaLayoutGuide, offsetBy: -20),
            .align(.centerX),
            .align(.leading, .greaterThanOrEqual, to: .leadingMargin),
            .align(.trailing, .lessThanOrEqual, to: .trailingMargin)
        )

        view.addSubview(center)
        center.applyConstraints(
            .centerWithinMargins(),
            .setSize(CGSize(width: 100, height: 100))
        )

        let guide = UILayoutGuide()
        view.addLayoutGuide(guide)
        guide.applyConstraints(
            .align(.top, to: .bottom, of: center),
            .align(.bottom, to: .top, of: loginButton),
            .align(.centerX)
        )

        view.addSubview(red)
        red.applyConstraints(
            .center(in: guide),
            .matchSize(of: center, ratio: 0.5)
        )
    }
}

let viewController = Example()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
