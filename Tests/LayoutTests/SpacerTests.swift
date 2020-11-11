import UIKit
import XCTest

import Layout

class SpacerTests: XCTestCase {
    func testVertical() {
        let spacer = VerticalSpacer(minimumLength: 100)
        XCTAssertEqual(spacer.intrinsicContentSize, CGSize(width: UIView.noIntrinsicMetric, height: 8000))
        XCTAssertEqual(spacer.contentHuggingPriority(for: .vertical), .init(1))
        XCTAssertEqual(spacer.contentCompressionResistancePriority(for: .vertical), .init(1))
        let constraint = spacer.constraints.first
        XCTAssertEqual(constraint?.firstAttribute, .height)
        XCTAssertEqual(constraint?.constant, 100)
        XCTAssertEqual(constraint?.priority, .defaultLow)
    }

    func testHorizontal() {
        let spacer = HorizontalSpacer(minimumLength: 100)
        XCTAssertEqual(spacer.intrinsicContentSize, CGSize(width: 8000, height: UIView.noIntrinsicMetric))
        XCTAssertEqual(spacer.contentHuggingPriority(for: .horizontal), .init(1))
        XCTAssertEqual(spacer.contentCompressionResistancePriority(for: .horizontal), .init(1))
        let constraint = spacer.constraints.first
        XCTAssertEqual(constraint?.firstAttribute, .width)
        XCTAssertEqual(constraint?.constant, 100)
        XCTAssertEqual(constraint?.priority, .defaultLow)
    }
}
