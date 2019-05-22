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

import UIKit

final class NonLayoutViewController: BaseViewController {

    private var activeConstraints = [NSLayoutConstraint]()

    private var regularConstraints = [NSLayoutConstraint]()

    private var regulerGreaterThanOrEqualTo1024Constraints = [NSLayoutConstraint]()

    private var regulerLessThan1024Constraints = [NSLayoutConstraint]()

    private var compactConstraints = [NSLayoutConstraint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        button.translatesAutoresizingMaskIntoConstraints = false
        redSquare.translatesAutoresizingMaskIntoConstraints = false
        greenSquare.translatesAutoresizingMaskIntoConstraints = false

        // Setup always active constraints
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redSquare.widthAnchor.constraint(equalTo: greenSquare.widthAnchor, multiplier: 0.5),
            redSquare.heightAnchor.constraint(equalTo: greenSquare.heightAnchor, multiplier: 0.5)
            ])

        regularConstraints = [
            greenSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            redSquare.centerXAnchor.constraint(equalTo: greenSquare.centerXAnchor),
            redSquare.centerYAnchor.constraint(equalTo: greenSquare.centerYAnchor)
        ]

        regulerGreaterThanOrEqualTo1024Constraints = [
            greenSquare.widthAnchor.constraint(equalToConstant: 400),
            greenSquare.heightAnchor.constraint(equalToConstant: 400)
        ]

        regulerLessThan1024Constraints = [
            greenSquare.widthAnchor.constraint(equalToConstant: 150),
            greenSquare.heightAnchor.constraint(equalToConstant: 150)
        ]

        compactConstraints = [
            greenSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(
                item: greenSquare,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view,
                attribute: .bottom,
                multiplier: 1 / 3,
                constant: 0
            ),
            greenSquare.widthAnchor.constraint(equalToConstant: 100),
            greenSquare.heightAnchor.constraint(equalToConstant: 100),
            redSquare.leadingAnchor.constraint(equalTo: greenSquare.leadingAnchor),
            redSquare.topAnchor.constraint(equalTo: greenSquare.topAnchor)
        ]
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        NSLayoutConstraint.deactivate(activeConstraints)
        activeConstraints = []

        if view.traitCollection.horizontalSizeClass == .regular {
            activeConstraints += regularConstraints

            if view.bounds.size.width >= 1_024 {
                activeConstraints += regulerGreaterThanOrEqualTo1024Constraints
            } else {
                activeConstraints += regulerLessThan1024Constraints
            }
        } else {
            activeConstraints += compactConstraints
        }

        NSLayoutConstraint.activate(activeConstraints)
    }
}
