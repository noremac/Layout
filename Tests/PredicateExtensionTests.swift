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

// swiftlint:disable multiline_arguments_brackets

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
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .verticallyUnspecified
            .evaluate(with: .init(traitCollection: UITraitCollection(verticalSizeClass: .unspecified), size: .zero))
        )
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .verticallyRegular
            .evaluate(with: .init(traitCollection: UITraitCollection(verticalSizeClass: .regular), size: .zero))
        )
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .verticallyCompact
            .evaluate(with: .init(traitCollection: UITraitCollection(verticalSizeClass: .compact), size: .zero))
        )

        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .horizontallyUnspecified
            .evaluate(with: .init(traitCollection: UITraitCollection(horizontalSizeClass: .unspecified), size: .zero))
        )
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .horizontallyRegular
            .evaluate(with: .init(traitCollection: UITraitCollection(horizontalSizeClass: .regular), size: .zero))
        )
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .horizontallyCompact
            .evaluate(with: .init(traitCollection: UITraitCollection(horizontalSizeClass: .compact), size: .zero))
        )
    }

    func testSize() {
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .width(is: >, 10)
            .evaluate(with: .init(traitCollection: UITraitCollection(), size: .init(width: 11, height: 10)))
        )
        XCTAssertTrue(DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>
            .Predicate
            .height(is: >, 10)
            .evaluate(with: .init(traitCollection: UITraitCollection(), size: .init(width: 10, height: 11)))
        )
    }
}
