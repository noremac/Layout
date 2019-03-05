/*
 The MIT License (MIT)

 Copyright (c) 2019 Cameron Pulsford

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

class TypeSafeAttributeAnchorTests: XCTestCase {

    func testAnchorsMatch() {
        let view = UIView()
        XCTAssertEqual(view.leftAnchor, XAttribute.left.anchor(view))
        XCTAssertEqual(view.rightAnchor, XAttribute.right.anchor(view))
        XCTAssertEqual(view.leadingAnchor, XAttribute.leading.anchor(view))
        XCTAssertEqual(view.trailingAnchor, XAttribute.trailing.anchor(view))
        XCTAssertEqual(view.centerXAnchor, XAttribute.centerX.anchor(view))

        XCTAssertEqual(view.topAnchor, YAttribute.top.anchor(view))
        XCTAssertEqual(view.bottomAnchor, YAttribute.bottom.anchor(view))
        XCTAssertEqual(view.firstBaselineAnchor, YAttribute.firstBaseline.anchor(view))
        XCTAssertEqual(view.lastBaselineAnchor, YAttribute.lastBaseline.anchor(view))
        XCTAssertEqual(view.centerYAnchor, YAttribute.centerY.anchor(view))

        XCTAssertEqual(view.widthAnchor, DimensionAttribute.width.anchor(view))
        XCTAssertEqual(view.heightAnchor, DimensionAttribute.height.anchor(view))
    }
}
