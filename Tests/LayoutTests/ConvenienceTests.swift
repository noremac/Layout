import UIKit
import XCTest

import Layout

class ConvenienceTests: XCTestCase {
    var view: UIView!

    override func setUp() {
        super.setUp()
        view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func testVerticalContentHuggingPriority() {
        view.verticalContentHuggingPriority(.defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .vertical), .defaultHigh)
    }

    func testHorizontalContentHuggingPriority() {
        view.horizontalContentHuggingPriority(.defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .horizontal), .defaultHigh)
    }

    func testContentHuggingPriority() {
        view.contentHuggingPriority(.defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .vertical), .defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .horizontal), .defaultHigh)
    }

    func testVerticalContentCompressionResistance() {
        view.verticalContentCompressionResistance(.defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .vertical), .defaultHigh)
    }

    func testHorizontalContentCompressionResistance() {
        view.horizontalContentCompressionResistance(.defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .horizontal), .defaultHigh)
    }

    func testContentCompressionResistance() {
        view.contentCompressionResistance(.defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .vertical), .defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .horizontal), .defaultHigh)
    }

    func testContentCompressionResistanceAndHuggingPriority() {
        view.contentCompressionResistanceAndHuggingPriority(.defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .vertical), .defaultHigh)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .horizontal), .defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .vertical), .defaultHigh)
        XCTAssertEqual(view.contentHuggingPriority(for: .horizontal), .defaultHigh)
    }

    func testAddAsSubview() {
        let parent = UIView()
        view.addAsSubview(to: parent)
        XCTAssertEqual(view.superview, parent)
    }
}
