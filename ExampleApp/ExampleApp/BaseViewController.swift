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

class BaseViewController: UIViewController {
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
            self.view.setNeedsUpdateConstraints()
            self.view.updateConstraintsIfNeeded()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
