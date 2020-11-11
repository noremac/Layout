/*
 The MIT License (MIT)

 Copyright (c) 2020 Cameron Pulsford

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

public extension UIView {
    static func build(@ArrayBuilder<ConstrainableItem> items: () -> [ConstrainableItem]) -> UIView {
        let superview = UIView()
        add(constrainableItems: items(), to: superview)
        return superview
    }
}

public extension UILayoutGuide {
    static func build(@ArrayBuilder<ConstrainableItem> items: () -> [ConstrainableItem]) -> UILayoutGuide {
        GuideBuilder(constrainableItems: items())
    }
}

private final class GuideBuilder: UILayoutGuide {
    var constrainableItems: [ConstrainableItem]

    init(constrainableItems: [ConstrainableItem]) {
        self.constrainableItems = constrainableItems
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var owningView: UIView? {
        didSet {
            if let superview = owningView, !constrainableItems.isEmpty {
                constrainableItems.forEach({ $0.toItem = self })
                add(constrainableItems: constrainableItems, to: superview)
                constrainableItems.forEach({ $0.toItem = nil })
                constrainableItems.removeAll()
            }
        }
    }
}

private func add(constrainableItems: [ConstrainableItem], to superview: UIView) {
    constrainableItems.flatMap { item -> [NSLayoutConstraint] in
        if let view = item as? UIView {
            superview.addSubview(view)
            return view._additionalConstraints.map(view.makeConstraints(groups:)) ?? []
        } else if let guide = item as? UILayoutGuide {
            superview.addLayoutGuide(guide)
            return guide._additionalConstraints.map(guide.makeConstraints(groups:)) ?? []
        } else {
            FatalError.crash("Unknown item type: \(type(of: item))", #file, #line)
            return []
        }
    }
    .activate()
}
