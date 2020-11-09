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
