import UIKit
import XCTest

import Layout

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
