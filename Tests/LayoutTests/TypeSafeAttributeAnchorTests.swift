import UIKit
import XCTest

import Layout

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

        let guide = UILayoutGuide()
        XCTAssertEqual(guide.leftAnchor, XAttribute.left.anchor(guide))
        XCTAssertEqual(guide.rightAnchor, XAttribute.right.anchor(guide))
        XCTAssertEqual(guide.leadingAnchor, XAttribute.leading.anchor(guide))
        XCTAssertEqual(guide.trailingAnchor, XAttribute.trailing.anchor(guide))
        XCTAssertEqual(guide.centerXAnchor, XAttribute.centerX.anchor(guide))

        XCTAssertEqual(guide.topAnchor, YAttribute.top.anchor(guide))
        XCTAssertEqual(guide.bottomAnchor, YAttribute.bottom.anchor(guide))
        XCTAssertEqual(guide.topAnchor, YAttribute.firstBaseline.anchor(guide))
        XCTAssertEqual(guide.bottomAnchor, YAttribute.lastBaseline.anchor(guide))
        XCTAssertEqual(guide.centerYAnchor, YAttribute.centerY.anchor(guide))

        XCTAssertEqual(guide.widthAnchor, DimensionAttribute.width.anchor(guide))
        XCTAssertEqual(guide.heightAnchor, DimensionAttribute.height.anchor(guide))
    }
}
