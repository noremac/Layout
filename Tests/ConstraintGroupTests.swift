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

@testable import Layout

class ConstraintGroupTests: XCTestCase {

    var parentView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        parentView = UIView()
        view = UIView()
        parentView.addSubview(view)
    }

    func testAlignX() {
        let desiredConstraints = [
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

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView, multiplier: 1, offsetBy: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView, multiplier: 1))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal, to: .leading))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading, .equal))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.leading))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignY() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .top,
                multiplier: 1,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView, multiplier: 1, offsetBy: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView, multiplier: 1))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal, to: .top))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top, .equal))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.align(.top))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testFixed() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.setFixed(.width, .equal, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setFixed(.width, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testRelative() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 0.5,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()

        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView, attribute: .width, constant: 0))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView, attribute: .width))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5, of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, .equal, to: 0.5))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.setRelative(.width, to: 0.5))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToEdges() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .top,
                multiplier: 1,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .leading,
                multiplier: 1,
                constant: 2
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .bottom,
                multiplier: 1,
                constant: -3
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .trailing,
                multiplier: 1,
                constant: -4
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.alignToEdges(of: parentView, insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.alignToEdges(insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqual(desiredConstraints, constraints)

        desiredConstraints.setConstant(0)
        constraints = view.makeConstraints(.alignToEdges())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToMargins() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .top,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .topMargin,
                multiplier: 1,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .leading,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .leadingMargin,
                multiplier: 1,
                constant: 2
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .bottomMargin,
                multiplier: 1,
                constant: -3
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .trailingMargin,
                multiplier: 1,
                constant: -4
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.alignEdgesToMargins(of: parentView, insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.alignEdgesToMargins(insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqual(desiredConstraints, constraints)

        desiredConstraints.setConstant(0)
        constraints = view.makeConstraints(.alignEdgesToMargins())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testCenter() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.center(in: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.center())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testCenterWithinMargins() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerXWithinMargins,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerYWithinMargins,
                multiplier: 1,
                constant: 0
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.centerWithinMargins(of: parentView))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.centerWithinMargins())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testSetSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 2
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.setSize(CGSize(width: 1, height: 2)))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testMatchSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 0.5,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .height,
                multiplier: 0.5,
                constant: 1
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.matchSize(of: parentView, ratio: 0.5, constant: 1))
        XCTAssertEqual(desiredConstraints, constraints)
        constraints = view.makeConstraints(.matchSize(ratio: 0.5, constant: 1))
        XCTAssertEqual(desiredConstraints, constraints)

        desiredConstraints.setConstant(0)
        constraints = view.makeConstraints(.matchSize(ratio: 0.5))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testPriorityOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]

        desiredConstraints.forEach { $0.priority = .defaultLow }

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.setFixed(.width, to: 100) ~ .defaultLow)
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testIdentifierOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]

        desiredConstraints.forEach { $0.identifier = "hi" }

        var constraints = [NSLayoutConstraint]()
        constraints = view.makeConstraints(.setFixed(.width, to: 100) <- "hi")
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAppliedConstraintsAreActive() {
        let constraints = view.applyConstraints(.setFixed(.width, to: 100))
        XCTAssertTrue(constraints.allSatisfy({ $0.isActive }))
    }

    func testActivateAndDeactivate() {
        let constraints = view.applyConstraints(.setFixed(.width, to: 100))
        XCTAssertTrue(constraints.allSatisfy({ $0.isActive }))
        constraints.deactivate()
        XCTAssertTrue(constraints.allSatisfy({ !$0.isActive }))
    }

    func testAnchorEquality() {
        let c1 = view.makeConstraints(
            .setFixed(.width, to: 100),
            .setFixed(.height, to: 100)
        )
        let c2 = view.makeConstraints(
            .with({ $0.widthAnchor.constraint(equalToConstant: 100) }),
            .with({ $0.heightAnchor.constraint(equalToConstant: 100) })
        )
        XCTAssertEqual(c1, c2)
    }
}
