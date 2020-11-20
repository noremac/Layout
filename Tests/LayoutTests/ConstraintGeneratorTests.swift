import UIKit
import XCTest

@testable import Layout

class ConstraintGeneratorTests: XCTestCase {
    var parentView: UIView!
    var view1: UIView!
    var view2: UIView!
    var layoutGuide: UILayoutGuide!

    override func setUp() {
        super.setUp()
        parentView = .init()
        view1 = .init()
        view2 = .init()
        layoutGuide = .init()
        parentView.addSubview(view1)
        parentView.addSubview(view2)
        parentView.addLayoutGuide(layoutGuide)
    }

    func testNoParentViewCrash() {
        let crashed = FatalError.withTestFatalError {
            UIView().applyConstraints {
                Leading()
            }
        }
        XCTAssertTrue(crashed)
    }
}
