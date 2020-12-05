import UIKit
import XCTest

import Layout

class TestConstraintAutoIdentifiers: XCTestCase {
    func testConstraintAutoIdentifiers() {
        let view = UIView()
        let constraints = view.makeConstraints(.fixedWidth(1))
        XCTAssertEqual(constraints[0].identifier, "TestConstraintAutoIdentifiers.swift:9")
    }
}
