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
import XCTest

// Give NSLayoutConstraint a better == implementation.
// It looks like it's just using === under the hood
// which is not convenient for tests.
//
// ...and test that it works in tests.

class ConstraintEqualityTests: XCTestCase {

    var parentView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        parentView = UIView()
        view = UIView()
        parentView.addSubview(view)
    }

    func testEquality() {
        let c1a = [
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        ]

        let c1b = [
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .leading,
                multiplier: 1,
                constant: 0
            )
        ]

        let c2 = [
            NSLayoutConstraint(
                item: view,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .trailing,
                multiplier: 1,
                constant: 1
            )
        ]

        XCTAssertEqual(c1a, c1a)
        XCTAssertEqual(c1a, c1b)
        XCTAssertNotEqual(c1a, c2)
    }
}

extension NSLayoutConstraint {

    // swiftlint:disable:next override_in_extension
    override open func isEqual(_ object: Any?) -> Bool {
        guard let otherConstraint = object as? NSLayoutConstraint else {
            return false
        }
        return self.firstItem === otherConstraint.firstItem
            && self.firstAttribute == otherConstraint.firstAttribute
            && self.secondItem === otherConstraint.secondItem
            && self.secondAttribute == otherConstraint.secondAttribute
            && self.relation == otherConstraint.relation
            && self.multiplier == otherConstraint.multiplier
            && self.constant == otherConstraint.constant
            && self.priority == otherConstraint.priority
            && self.identifier == otherConstraint.identifier
            && self.isActive == otherConstraint.isActive
    }
}
