import Layout
import UIKit
import XCTest

final class CenterTests: XCTestCase {
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
        let constraints = view1.makeConstraints {
            CenterX(.greaterThanOrEqual, to: view2, attribute: .leading, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testCenterXDefaults() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: parentView.centerXAnchor)
        ]
        let constraints = view1.makeConstraints {
            CenterX()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            CenterY(.greaterThanOrEqual, to: view2, attribute: .top, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testCenterYDefaults() {
        let desiredConstraints = [
            view1.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ]
        let constraints = view1.makeConstraints {
            CenterY()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testCenter() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: view2.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: view2.centerYAnchor)
        ]
        let constraints = view1.makeConstraints {
            Center(in: view2)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testCenterDefaults() {
        let desiredConstraints = [
            view1.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ]
        let constraints = view1.makeConstraints {
            Center()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }
}
