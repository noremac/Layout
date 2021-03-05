import Layout
import PlaygroundSupport
import SwiftUI
import UIKit

class MyViewController: UIViewController {
    let image: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let badge: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title!"
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()

    let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary!"
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "30 minutes"
        label.textColor = .secondaryLabel
        return label
    }()

    let playButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "play"), for: .normal)
        return view
    }()

    override func loadView() {
        view = UIStackView.vertical(spacing: 10) {
            image
                .overlay {
                    badge.constraints {
                        AlignEdges([.bottom, .trailing], insets: 8)
                        Size(width: 20, height: 20)
                    }
                }
                .constraints {
                    AspectRatio(3 / 2)
                }

            UIStackView.vertical(spacing: 10) {
                titleLabel
                summaryLabel
                    .spacingAfter(20)
                UIStackView.horizontal {
                    timeLabel
                    HorizontalSpacer()
                    playButton
                }
            }
            .padding(.horizontal, insets: 8)

            VerticalSpacer()
        }
    }
}

PlaygroundPage.current.liveView = MyViewController()
