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
    @discardableResult
    func contentCompressionResistanceAndHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .horizontal)
        setContentHuggingPriority(priority, for: .vertical)
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func contentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func verticalContentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .vertical)
        return self
    }

    @discardableResult
    func horizontalContentCompressionResistance(_ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func contentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .vertical)
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func verticalContentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .vertical)
        return self
    }

    @discardableResult
    func horizontalContentHuggingPriority(_ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: .horizontal)
        return self
    }

    @discardableResult
    func addAsSubview(to parentView: UIView) -> Self {
        parentView.addSubview(self)
        return self
    }
}
