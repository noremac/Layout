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
            ctx += button.makeConstraints(
                .bottom(),
                .alignVerticalEdges()
            )
            ctx += redSquare.makeConstraints(
                .relativeSize(to: greenSquare, multiplier: 0.5)
            )

            ctx.when(.horizontallyRegular, { ctx in
                ctx += greenSquare.makeConstraints(
                    .center()
                )
                ctx += redSquare.makeConstraints(
                    .center(in: greenSquare)
                )

                ctx.when(.width(is: >=, 1_024), { ctx in
                    ctx += greenSquare.makeConstraints(
                        .size(CGSize(width: 400, height: 400))
                    )
                }, otherwise: { ctx in
                    ctx += greenSquare.makeConstraints(
                        .size(CGSize(width: 150, height: 150))
                    )
                })
            }, otherwise: { ctx in
                ctx += greenSquare.makeConstraints(
                    .centerX(),
                    .centerY(attribute: .bottom, multiplier: 1 / 3),
                    .size(CGSize(width: 100, height: 100))
                )
                ctx += redSquare.makeConstraints(
                    .leading(to: greenSquare),
                    .top(to: greenSquare)
                )
            })
        }
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        layout.update(environment: .init(traitCollection: view.traitCollection, size: view.bounds.size))
    }
}
