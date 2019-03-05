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
    var view1: UIView!
    var view2: UIView!
    var layoutGuide: UILayoutGuide!

    override func setUp() {
        ConstraintGroup.debugConstraints = false
        super.setUp()
        parentView = UIView()
        view1 = UIView()
        view2 = UIView()
        layoutGuide = UILayoutGuide()
        parentView.addSubview(view1)
        parentView.addSubview(view2)
        parentView.addLayoutGuide(layoutGuide)
    }

    func testAlignX() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .leading,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .trailing,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.align(.leading, .greaterThanOrEqual, to: .trailing, of: view2, multiplier: 2, offsetBy: 8))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignXDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        ]
        let constraints = view1.makeConstraints(.align(.leading))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignY() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .top,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .bottom,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.align(.top, .greaterThanOrEqual, to: .bottom, of: view2, multiplier: 2, offsetBy: 8))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignYDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor)
        ]
        let constraints = view1.makeConstraints(.align(.top))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testFixed() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]
        let constraints = view1.makeConstraints(.setFixed(.width, .greaterThanOrEqual, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testFixedDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.setFixed(.width, to: 100))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testRelative() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.heightAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.setRelative(.width, .greaterThanOrEqual, to: 0.5, of: view2, attribute: .height, constant: 2))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testRelativeDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1, constant: 0)
        ]
        let constraints = view1.makeConstraints(.setRelative(.width))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1),
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 2),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -3),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignToEdges(of: view2, insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToEdges())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToVerticalEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -3)
        ]
        let constraints = view1.makeConstraints(.alignToVerticalEdges(of: view2, topInset: 1, bottomInset: 3))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToVerticalEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToVerticalEdges())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdges() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 2),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignToHorizontalEdges(of: view2, leadingInset: 2, trailingInset: 4))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdgesDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToHorizontalEdges())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testCenter() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: view2,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view2,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints = view1.makeConstraints(.center(in: view2))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testCenterDefaults() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints = view1.makeConstraints(.center())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testSetSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 2
            )
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.setSize(CGSize(width: 1, height: 2)))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testMatchSize() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .width,
                multiplier: 0.5,
                constant: 2
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .height,
                multiplier: 0.5,
                constant: 2
            )
        ]
        let constraints = view1.makeConstraints(.matchSize(of: view2, .greaterThanOrEqual, ratio: 0.5, constant: 2))
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testMatchSizeDefaults() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .height,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints = view1.makeConstraints(.matchSize())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testPriorityOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
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
        constraints = view1.makeConstraints(.setFixed(.width, to: 100) ~ .defaultLow)
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testIdentifierOperator() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1,
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
        constraints = view1.makeConstraints(.setFixed(.width, to: 100) <- "hi")
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testAppliedConstraintsAreActive() {
        let constraints = view1.applyConstraints(.setFixed(.width, to: 100))
        XCTAssertTrue(constraints.allSatisfy({ $0.isActive }))
    }

    func testActivateAndDeactivate() {
        let constraints = view1.applyConstraints(.setFixed(.width, to: 100))
        XCTAssertTrue(constraints.allSatisfy({ $0.isActive }))
        constraints.deactivate()
        XCTAssertTrue(constraints.allSatisfy({ !$0.isActive }))
    }

    func testChangesAllConstants() {
        let constraints = [
            NSLayoutConstraint(
                item: view1,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            ),
            NSLayoutConstraint(
                item: view1,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 100
            )
        ]
        XCTAssertTrue(constraints.allSatisfy({ $0.constant == 100 }))
        constraints.setConstant(50)
        XCTAssertTrue(constraints.allSatisfy({ $0.constant == 50 }))
    }

    func testAnchorEquality() {
        let c1 = view1.makeConstraints(
            .setFixed(.width, to: 100),
            .setFixed(.height, to: 100)
        )
        let c2 = view1.makeConstraints(
            .with({ $0.widthAnchor.constraint(equalToConstant: 100) }),
            .with({ $0.heightAnchor.constraint(equalToConstant: 100) })
        )
        XCTAssertEqual(c1, c2)
    }

    func testLayoutGuides() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: layoutGuide,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: layoutGuide,
                attribute: .height,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints = layoutGuide.makeConstraints(.matchSize())
        XCTAssertEqual(desiredConstraints, constraints)
    }

    func testThrowsErrors() {
        let view = UIView()
        let layoutGuide = UILayoutGuide()
        XCTAssertThrowsError(try view.parentView())
        XCTAssertThrowsError(try layoutGuide.parentView())
        parentView.addSubview(view)
        parentView.addLayoutGuide(layoutGuide)
        XCTAssertNoThrow(try view.parentView())
        XCTAssertNoThrow(try layoutGuide.parentView())
    }
}
