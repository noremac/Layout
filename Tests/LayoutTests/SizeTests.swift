import Layout
import UIKit
import XCTest

final class SizeTests: XCTestCase {
    var parentView: UIView!
    var view1: UIView!
    var view2: UIView!

    override func setUp() {
        super.setUp()
        parentView = .init()
        view1 = .init()
        view2 = .init()
        parentView.addSubview(view1)
        parentView.addSubview(view2)
    }

    func testWidth1() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Width(.greaterThanOrEqual, 8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testWidth2() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Width(8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testWidth3() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: view2!,
                attribute: .height,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Width(.greaterThanOrEqual, to: view2, attribute: .height, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testWidth3Defaults() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .width,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints1 = view1.makeConstraints {
            Width()
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testHeight() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Height(.greaterThanOrEqual, 8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testHeight2() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Height(8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testHeight3() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: view2!,
                attribute: .width,
                multiplier: 2,
                constant: 8
            )
        ]
        let constraints1 = view1.makeConstraints {
            Height(.greaterThanOrEqual, to: view2, attribute: .width, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testHeight3Defaults() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .equal,
                toItem: parentView,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints1 = view1.makeConstraints {
            Height()
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testSize1() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 1
            ),
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 2
            )
        ]
        let constraints1 = view1.makeConstraints {
            Size(width: 1, height: 2)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testSize2() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: view2!,
                attribute: .width,
                multiplier: 2,
                constant: 3
            ),
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: view2!,
                attribute: .height,
                multiplier: 2,
                constant: 3
            )
        ]
        let constraints1 = view1.makeConstraints {
            Size(.greaterThanOrEqual, to: view2!, multiplier: 2, constant: 3)
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testSize2Defaults() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .equal,
                toItem: parentView!,
                attribute: .width,
                multiplier: 1,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view1!,
                attribute: .height,
                relatedBy: .equal,
                toItem: parentView!,
                attribute: .height,
                multiplier: 1,
                constant: 0
            )
        ]
        let constraints1 = view1.makeConstraints {
            Size()
        }
        XCTAssertEqualConstraints(constraints1, desiredConstraints)
    }

    func testAspectRatio() {
        let desiredConstraints = [
            NSLayoutConstraint(
                item: view1!,
                attribute: .width,
                relatedBy: .equal,
                toItem: view1!,
                attribute: .height,
                multiplier: 1.5,
                constant: 0
            )
        ]
        let constraints = view1.makeConstraints {
            AspectRatio(3 / 2)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }
}
