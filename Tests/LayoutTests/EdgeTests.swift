import Layout
import UIKit
import XCTest

final class EdgeTests: XCTestCase {
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
        let constraints = view1.makeConstraints {
            Top(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testTopDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor)
        ]
        let constraints = view1.makeConstraints {
            Top()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            Leading(.greaterThanOrEqual, to: view2, attribute: .trailing, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testLeadingDefaults() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor)
        ]
        let constraints = view1.makeConstraints {
            Leading()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            Bottom(.greaterThanOrEqual, to: view2, attribute: .centerY, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testBottomDefaults() {
        let desiredConstraints = [
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints {
            Bottom()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            Trailing(.greaterThanOrEqual, to: view2, attribute: .leading, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testTrailingDefaults() {
        let desiredConstraints = [
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints {
            Trailing()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesTop() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: view2.topAnchor, constant: 1)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.top, to: view2, insets: 1)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesLeading() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 1)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.leading, to: view2, insets: 1)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesBottom() {
        let desiredConstraints = [
            view1.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -1)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.bottom, to: view2, insets: 1)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesTrailing() {
        let desiredConstraints = [
            view1.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -1)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.trailing, to: view2, insets: 1)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesHorizontal() {
        let desiredConstraints = [
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.horizontal)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesVertical() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges(.vertical)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testAlignEdgesDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(equalTo: parentView.topAnchor),
            view1.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view1.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            view1.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints {
            AlignEdges()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testContainedDefaults() {
        let desiredConstraints = [
            view1.topAnchor.constraint(greaterThanOrEqualTo: parentView.topAnchor),
            view1.leadingAnchor.constraint(greaterThanOrEqualTo: parentView.leadingAnchor),
            view1.bottomAnchor.constraint(lessThanOrEqualTo: parentView.bottomAnchor),
            view1.trailingAnchor.constraint(lessThanOrEqualTo: parentView.trailingAnchor)
        ]
        let constraints = view1.makeConstraints {
            Contained()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            Left(.greaterThanOrEqual, to: view2, attribute: .right, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testLeftDefaults() {
        let desiredConstraints = [
            view1.leftAnchor.constraint(equalTo: parentView.leftAnchor)
        ]
        let constraints = view1.makeConstraints {
            Left()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
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
        let constraints = view1.makeConstraints {
            Right(.greaterThanOrEqual, to: view2, attribute: .left, multiplier: 2, constant: 8)
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }

    func testRightDefaults() {
        let desiredConstraints = [
            view1.rightAnchor.constraint(equalTo: parentView.rightAnchor)
        ]
        let constraints = view1.makeConstraints {
            Right()
        }
        XCTAssertEqualConstraints(constraints, desiredConstraints)
    }
}
