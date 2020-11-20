import UIKit
import XCTest

import Layout

class TestIdentifiers: XCTestCase {
    func testConstraintAutoIdentifiers() {
        let view = UIView()
        let constraints = view.makeConstraints {
            Width(1)
        }
        XCTAssertEqual(constraints[0].identifier, "TestConstraintAutoIdentifiers.swift:10")
    }

    func testIdentifierOperator() {
        let view = UIView()
        let constraints = view.makeConstraints {
            Width(1) <- "hello, world!"
        }
        XCTAssertEqual(constraints[0].identifier, "hello, world!")
    }
}
