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

    func testNoParentViewCrash() {
        let crashed = FatalError.withTestFatalError {
            UIView().applyConstraints(.leading())
        }
        XCTAssertTrue(crashed)
    }

    func testLeft() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .left,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .right,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.left(.greaterThanOrEqual, to: view2, attribute: .right, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testLeftDefaults() {
        let desiredConstraints = [
            view1.leftAnchor.constraint(equalTo: parentView.leftAnchor)
        ]
        let constraints = view1.makeConstraints(.left())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRight() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .right,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .left,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.right(.greaterThanOrEqual, to: view2, attribute: .left, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRightDefaults() {
        let desiredConstraints = [
            view1.rightAnchor.constraint(equalTo: parentView.rightAnchor)
        ]
        let constraints = view1.makeConstraints(.right())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testLeading() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .leading,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .trailing,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.leading(.greaterThanOrEqual, to: view2, attribute: .trailing, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testLeadingDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        ]
        let constraints = view1.makeConstraints(.leading())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testTrailing() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .trailing,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .leading,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.trailing(.greaterThanOrEqual, to: view2, attribute: .leading, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testTrailingDefaults() {
        let desiredConstraints = [
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.trailing())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenterX() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .centerX,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .leading,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.centerX(.greaterThanOrEqual, to: view2, attribute: .leading, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenterXDefaults() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        ]
        let constraints = view1.makeConstraints(.centerX())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenterY() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .centerY,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .top,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.centerY(.greaterThanOrEqual, to: view2, attribute: .top, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testCenterYDefaults() {
        let desiredConstraints = [
            view1.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ]
        let constraints = view1.makeConstraints(.centerY())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testTop() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .top,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .centerY,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.top(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testTopDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor)
        ]
        let constraints = view1.makeConstraints(.top())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testBottom() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .bottom,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .centerY,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.bottom(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testBottomDefaults() {
        let desiredConstraints = [
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints(.bottom())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFirstBaseline() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .firstBaseline,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .centerY,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.firstBaseline(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFirstBaselineDefaults() {
        let desiredConstraints = [
            view1.firstBaselineAnchor.constraint(equalTo: parentView.firstBaselineAnchor)
        ]
        let constraints = view1.makeConstraints(.firstBaseline())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testLastBaseline() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .lastBaseline,
                relatedBy: .greaterThanOrEqual,
                toItem: view2,
                attribute: .centerY,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints = view1.makeConstraints(.lastBaseline(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testLastBaselineDefaults() {
        let desiredConstraints = [
            view1.lastBaselineAnchor.constraint(equalTo: parentView.lastBaselineAnchor)
        ]
        let constraints = view1.makeConstraints(.lastBaseline())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixedWidth() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.fixedWidth(.greaterThanOrEqual, 100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixedWidthDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.fixedWidth(100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixedHeight() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.fixedHeight(.greaterThanOrEqual, 100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testFixedHeightDefaults() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(equalToConstant: 100)
        ]
        let constraints = view1.makeConstraints(.fixedHeight(100))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeWidth() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(lessThanOrEqualTo: view2.heightAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.relativeWidth(.lessThanOrEqual, to: view2, attribute: .height, multiplier: 0.5, constant: 2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeWidthDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1, constant: 0)
        ]
        let constraints = view1.makeConstraints(.relativeWidth())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeHeight() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.widthAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.relativeHeight(.greaterThanOrEqual, to: view2, attribute: .width, multiplier: 0.5, constant: 2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeHeightDefaults() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1, constant: 0)
        ]
        let constraints = view1.makeConstraints(.relativeHeight())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1),
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 2),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -3),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignEdges(to: view2, insets: .init(top: 1, leading: 2, bottom: 3, trailing: 4)))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignEdges())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignVerticalEdges() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 1),
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -3)
        ]
        let constraints = view1.makeConstraints(.alignVerticalEdges(to: view2, leadingInset: 1, trailingInset: 3))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignVerticalEdgesDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints(.alignVerticalEdges())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdges() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 2),
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -4)
        ]
        let constraints = view1.makeConstraints(.alignHorizontalEdges(to: view2, topInset: 2, bottomInset: 4))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAlignToHorizontalEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints(.alignHorizontalEdges())
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

    func testSize() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 1),
            view1.heightAnchor.constraint(equalToConstant: 2)
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.size(CGSize(width: 1, height: 2)))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testSizeRelation() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualToConstant: 1),
            view1.heightAnchor.constraint(greaterThanOrEqualToConstant: 2)
        ]

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.size(.greaterThanOrEqual, CGSize(width: 1, height: 2)))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeSize() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.widthAnchor, multiplier: 0.5, constant: 2),
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.heightAnchor, multiplier: 0.5, constant: 2)
        ]
        let constraints = view1.makeConstraints(.relativeSize(.greaterThanOrEqual, to: view2, multiplier: 0.5, constant: 2))
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testRelativeSizeDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1, constant: 0),
            view1.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1, constant: 0)
        ]
        let constraints = view1.makeConstraints(.relativeSize())
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testPriorityOperator() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]

        desiredConstraints.forEach { $0.priority = .defaultLow }

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.fixedWidth(100) ~ .defaultLow)
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testPriorityOperatorWithFloat() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]

        desiredConstraints.forEach { $0.priority = .init(250) }

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.fixedWidth(100) ~ 250)
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testIdentifierOperator() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalToConstant: 100)
        ]

        desiredConstraints.forEach { $0.identifier = "hi" }

        var constraints = [NSLayoutConstraint]()
        constraints = view1.makeConstraints(.fixedWidth(100) <- "hi")
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testAppliedConstraintsAreActive() {
        let constraints = view1.applyConstraints(.fixedWidth(100))
        XCTAssertTrue(constraints.allSatisfy({ $0.isActive }))
    }

    func testActivateAndDeactivate() {
        let constraints = view1.applyConstraints(.fixedWidth(100))
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
            .fixedWidth(100),
            .fixedHeight(100)
        )
        let c2 = [
            view1.widthAnchor.constraint(equalToConstant: 100),
            view1.heightAnchor.constraint(equalToConstant: 100)
        ]
        XCTAssertEqualConstraints(c1, c2)
    }

    func testLayoutGuides() {
        let desiredConstraints = [
            layoutGuide.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            layoutGuide.heightAnchor.constraint(equalTo: parentView.heightAnchor)
        ]
        let constraints = layoutGuide.makeConstraints(.relativeSize())
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
            view1.widthAnchor.constraint(greaterThanOrEqualTo: view2.leadingAnchor.anchorWithOffset(to: parentView.leadingAnchor), multiplier: 2, constant: 1),
            view1.widthAnchor.constraint(lessThanOrEqualTo: view2.leadingAnchor.anchorWithOffset(to: parentView.leadingAnchor), multiplier: 2, constant: 1)
        ]
        let constraints = view1.makeConstraints(
            .match(.width, .greaterThanOrEqual, toSpaceBetween: view2.leadingAnchor, and: parentView.leadingAnchor, multiplier: 2, constant: 1),
            .match(.width, .lessThanOrEqual, toSpaceBetween: view2.leadingAnchor, and: parentView.leadingAnchor, multiplier: 2, constant: 1)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionXDefaults() {
        let desiredConstraints = [
            view1.widthAnchor.constraint(equalTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor))
        ]
        let constraints = view1.makeConstraints(
            .match(.width, toSpaceBetween: view2.leadingAnchor, and: parentView.leadingAnchor)
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }

    func testMatchDimensionY() {
        let desiredConstraints = [
            view1.heightAnchor.constraint(greaterThanOrEqualTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor), multiplier: 2, constant: 1),
            view1.heightAnchor.constraint(lessThanOrEqualTo: view2.topAnchor.anchorWithOffset(to: parentView.topAnchor), multiplier: 2, constant: 1)
        ]
        let constraints = view1.makeConstraints(
            .match(.height, .greaterThanOrEqual, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor, multiplier: 2, constant: 1),
            .match(.height, .lessThanOrEqual, toSpaceBetween: view2.topAnchor, and: parentView.topAnchor, multiplier: 2, constant: 1)
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

    func testCompsedOf() {
        let desiredConstraints = view1.makeConstraints(
            .leading(),
            .center()
        )
        let constraints = view1.makeConstraints(
            .init(
                file: "",
                line: 0,
                composedOf:
                .leading(),
                .center()
            )
        )
        XCTAssertEqualConstraints(desiredConstraints, constraints)
    }
}
