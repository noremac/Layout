import Layout
import PlaygroundSupport
import UIKit
import SwiftUI

class MyViewController : UIViewController {
    let red: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let green: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let labels: [UILabel] = {
        (1..<10).map({
            let label = UILabel()
            label.text = "Hello, world \($0)"
            return label
        })
    }()

    override func loadView() {
        self.view = UIView.build {
            red.constraints(
                .bottom(),
                .leading(),
                .size(CGSize(width: 100, height: 100))
            )
            green.constraints(
                .center(in: red),
                .relativeSize(to: red, multiplier: 0.5)
            )

            UIStackView.vertical(spacing: 8) {
                labels[0]
                labels[1]
                    .spacingAfter(40)
                labels[2]
                labels[3]
                labels[4]
                    .spacingAfter(0)
                labels[5]
            }
            .constraints(.center())
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
