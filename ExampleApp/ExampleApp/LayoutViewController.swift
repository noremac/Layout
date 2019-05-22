/*
 The MIT License (MIT)

 Copyright (c) 2019 Cameron Pulsford

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import Layout
import UIKit

final class LayoutViewController: BaseViewController {

    let layout = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            self.layout.update(environment: .init(traitCollection: self.view.traitCollection, size: size))
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
