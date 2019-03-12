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

class PredicateExtensionTests: XCTestCase {

    func testOr() {
        let alwaysTrue = DynamicLayout<Void>.Predicate({ _ in true })
        let alwaysFalse = DynamicLayout<Void>.Predicate({ _ in false })

        XCTAssertTrue((alwaysTrue || alwaysTrue).evaluate(with: ()))
        XCTAssertTrue((alwaysTrue || alwaysFalse).evaluate(with: ()))
        XCTAssertFalse((alwaysFalse || alwaysFalse).evaluate(with: ()))
    }

    func testAnd() {
        let alwaysTrue = DynamicLayout<Void>.Predicate({ _ in true })
        let alwaysFalse = DynamicLayout<Void>.Predicate({ _ in false })

        XCTAssertTrue((alwaysTrue && alwaysTrue).evaluate(with: ()))
        XCTAssertFalse((alwaysTrue && alwaysFalse).evaluate(with: ()))
        XCTAssertFalse((alwaysFalse && alwaysFalse).evaluate(with: ()))
    }

    func testAlwaysTrue() {
        XCTAssertTrue(DynamicLayout<Void>.Predicate.always.evaluate(with: ()))
    }

    func testNegate() {
        let never = !DynamicLayout<Void>.Predicate.always
        XCTAssertFalse(never.evaluate(with: ()))
    }

    func testSizeClasses() {
        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .verticallyUnspecified
            .evaluate(with: UITraitCollection(verticalSizeClass: .unspecified))
        )
        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .verticallyRegular
            .evaluate(with: UITraitCollection(verticalSizeClass: .regular))
        )
        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .verticallyCompact
            .evaluate(with: UITraitCollection(verticalSizeClass: .compact))
        )

        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .horizontallyUnspecified
            .evaluate(with: UITraitCollection(horizontalSizeClass: .unspecified))
        )
        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .horizontallyRegular
            .evaluate(with: UITraitCollection(horizontalSizeClass: .regular))
        )
        XCTAssertTrue(
            DynamicLayout<UITraitCollection>
            .Predicate
            .horizontallyCompact
            .evaluate(with: UITraitCollection(horizontalSizeClass: .compact))
        )
    }

    func testSize() {
        XCTAssertTrue(
            DynamicLayout<CGSize>
            .Predicate
            .width(is: >, 10)
            .evaluate(with: .init(width: 11, height: 10))
        )
        XCTAssertTrue(
            DynamicLayout<CGSize>
            .Predicate
            .height(is: >, 10)
            .evaluate(with: .init(width: 10, height: 11))
        )
    }
}
