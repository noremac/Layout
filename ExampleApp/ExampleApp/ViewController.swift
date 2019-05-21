//
//  ViewController.swift
//  ExampleApp
//
//  Created by Cameron Pulsford on 5/20/19.
//  Copyright © 2019 Wiggly Dog. All rights reserved.
//

import Layout
import UIKit

class ViewController: UIViewController {

    let layout = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()

    let greenSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    let redSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("BUTTON", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(greenSquare)
        view.addSubview(redSquare)
        view.addSubview(button)

        layout.configure { ctx in
            ctx.addConstraints(
                button.makeConstraints(
                    .align(.bottom),
                    .alignToHorizontalEdges()
                ),
                redSquare.makeConstraints(
                    .setRelativeSize(to: greenSquare, multiplier: 0.5)
                )
            )

            ctx.when(.horizontallyRegular, { ctx in
                ctx.addConstraints(
                    greenSquare.makeConstraints(
                        .center()
                    ),
                    redSquare.makeConstraints(
                        .center(in: greenSquare)
                    )
                )

                ctx.when(.width(is: >=, 1_024), { ctx in
                    ctx.addConstraints(
                        greenSquare.makeConstraints(
                            .setSize(to: CGSize(width: 400, height: 400))
                        )
                    )
                }, otherwise: { ctx in
                    ctx.addConstraints(
                        greenSquare.makeConstraints(
                            .setSize(to: CGSize(width: 150, height: 150))
                        )
                    )
                })
            }, otherwise: { ctx in
                ctx.addConstraints(
                    greenSquare.makeConstraints(
                        .align(.centerX),
                        .align(.centerY, attribute: .bottom, multiplier: 1 / 3),
                        .setSize(to: CGSize(width: 100, height: 100))
                    ),
                    redSquare.makeConstraints(
                        .align(.leading, to: greenSquare),
                        .align(.top, to: greenSquare)
                    )
                )
            })
        }

        layout.update(environment: .init(traitCollection: view.traitCollection, size: view.bounds.size))
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        button.contentEdgeInsets = .init(
            top: 10,
            left: 0,
            bottom: view?.safeAreaInsets.bottom ?? 0,
            right: 0
        )
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.layout.update(environment: .init(traitCollection: self.view.traitCollection, size: size))
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
