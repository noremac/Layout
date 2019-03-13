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
        parentView = .init()
        view1 = .init()
        view2 = .init()
        layoutGuide = .init()
        parentView.addSubview(view1)
        parentView.addSubview(view2)
        parentView.addLayoutGuide(layoutGuide)
    }

    override func tearDown() {
        ConstraintGroup.debugConstraints = true
        super.tearDown()
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
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignXDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        ]
        let constraints = view1.makeConstraints(.align(.leading))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
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
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignYDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor)
        ]
        let constraints = view1.makeConstraints(.align(.top))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixed() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.setFixed(.width, .greaterThanOrEqual, to: 100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixedDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.setFixed(.width, to: 100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelative() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.heightAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.setRelative(.width, .greaterThanOrEqual, to: 0.5, of: view2, attribute: .height, constant: 2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1, constant: 0)
        ]
        let constraints = view1.makeConstraints(.setRelative(.width))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1),
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 2),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -3),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignToEdges(of: view2, insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToEdges())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToVerticalEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -3)
        ]
        let constraints = view1.makeConstraints(.alignToVerticalEdges(of: view2, topInset: 1, bottomInset: 3))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToVerticalEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToVerticalEdges())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdges() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 2),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignToHorizontalEdges(of: view2, leadingInset: 2, trailingInset: 4))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdgesDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignToHorizontalEdges())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenter() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: view2.centerYAnchor)
        ]
        let constraints = view1.makeConstraints(.center(in: view2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenterDefaults() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ]
        let constraints = view1.makeConstraints(.center())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSetSize() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 1),
            view1.heightAnchor.constraint(equalToConstant: 2)
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.setSize(CGSize(width: 1, height: 2)))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchSize() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.widthAnchor, multiplier: 0.5, constant: 2),
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.heightAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.matchSize(of: view2, .greaterThanOrEqual, ratio: 0.5, constant: 2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchSizeDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            view1.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ]
        let constraints = view1.makeConstraints(.matchSize())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testPriorityOperator() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]

        desiredConstraints.forEach { $0.priority = .defaultLow }

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.setFixed(.width, to: 100) ~ .defaultLow)
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testIdentifierOperator() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]

        desiredConstraints.forEach { $0.identifier = "hi" }

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.setFixed(.width, to: 100) <- "hi")
        XCTAssertEqualConstraints(desiredConstraints, constraints)
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
            view1.widthAnchor.constraint(equalToConstant: 100),
            view1.heightAnchor.constraint(equalToConstant: 100)
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
        XCTAssertEqualConstraints(c1, c2)
    }

    func testLayoutGuides() {
        let desiredConstraints = [
            layoutGuide.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            layoutGuide.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ]
        let constraints = layoutGuide.makeConstraints(.matchSize())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSystemSpacingAfter() {
        let desiredConstraints = [
            view2.leadingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: view1.trailingAnchor, multiplier: 2),
            view2.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: view1.trailingAnchor, multiplier: 2)
        ]
        let constraints = view2.makeConstraints(
            .align(.leading, .lessThanOrEqual, toSystemSpacingAfter: view1.trailingAnchor, multiplier: 2),
            .align(.leading, .greaterThanOrEqual, toSystemSpacingAfter: view1.trailingAnchor, multiplier: 2)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSystemSpacingAfterDefaults() {
        let desiredConstraints = [
            view2.leadingAnchor.constraint(equalToSystemSpacingAfter: view1.trailingAnchor, multiplier: 1)
        ]
        let constraints = view2.makeConstraints(.align(.leading, toSystemSpacingAfter: view1.trailingAnchor))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSystemSpacingBelow() {
        let desiredConstraints = [
            view2.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view1.bottomAnchor, multiplier: 2),
            view2.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: view1.bottomAnchor, multiplier: 2)
        ]
        let constraints = view2.makeConstraints(
            .align(.top, .lessThanOrEqual, toSystemSpacingBelow: view1.bottomAnchor, multiplier: 2),
            .align(.top, .greaterThanOrEqual, toSystemSpacingBelow: view1.bottomAnchor, multiplier: 2)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSystemSpacingBelowDefaults() {
        let desiredConstraints = [
            view2.topAnchor.constraint(equalToSystemSpacingBelow: view1.bottomAnchor, multiplier: 1)
        ]
        let constraints = view2.makeConstraints(.align(.top, toSystemSpacingBelow: view1.bottomAnchor))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionX() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.leadingAnchor.anchorWithOffset(to: parentView.leadingAnchor), multiplier: 2, constant: 1),
            view1.widthAnchor.constraint(lessThanOrEqualTo: view2.leadingAnchor.anchorWithOffset(to: parentView.leadingAnchor), multiplier: 2, constant: 1)
        ]
        let constraints = view1.makeConstraints(
            .match(.height, .greaterThanOrEqual, toSpaceBetween: view2.leadingAnchor, and: parentView.leadingAnchor, multiplier: 2, constant: 1),
            .match(.width, .lessThanOrEqual, toSpaceBetween: view2.leadingAnchor, and: parentView.leadingAnchor, multiplier: 2, constant: 1)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionXDefaults() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(equalTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor))
        ]
        let constraints = view1.makeConstraints(
            .match(.height, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionY() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor), multiplier: 2, constant: 1),
            view1.widthAnchor.constraint(lessThanOrEqualTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor), multiplier: 2, constant: 1)
        ]
        let constraints = view1.makeConstraints(
            .match(.height, .greaterThanOrEqual, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor, multiplier: 2, constant: 1),
            .match(.width, .lessThanOrEqual, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor, multiplier: 2, constant: 1)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionYDefaults() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(equalTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor))
        ]
        let constraints = view1.makeConstraints(
            .match(.height, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCreationPerformance() {
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            let parentView = UIView()
            let views = (1...10_000).map({ _ in UIView() })
            views.forEach({ parentView.addSubview($0) })
            var constraints = [NSLayoutConstraint]()
            startMeasuring()
            for view in views {
                constraints += view.makeConstraints(.align(.leading))
            }
            stopMeasuring()
            print(constraints.count)
        })
    }
}
