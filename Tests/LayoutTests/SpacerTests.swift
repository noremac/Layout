/*
 The MIT License (MIT)

 Copyright (c) 2020 Cameron Pulsford

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
