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
import SwiftUI

@testable import Layout

enum TestEnum {
    case one
    case two
    case three
}

class BadThing: ConstrainableItem {
    var parentView: UIView?

    var leftAnchor: NSLayoutXAxisAnchor {
        fatalError("")
    }

    var rightAnchor: NSLayoutXAxisAnchor {
        fatalError("")
    }

    var leadingAnchor: NSLayoutXAxisAnchor {
        fatalError("")
    }

    var trailingAnchor: NSLayoutXAxisAnchor {
        fatalError("")
    }

    var topAnchor: NSLayoutYAxisAnchor {
        fatalError("")
    }

    var bottomAnchor: NSLayoutYAxisAnchor {
        fatalError("")
    }

    var widthAnchor: NSLayoutDimension {
        fatalError("")
    }

    var heightAnchor: NSLayoutDimension {
        fatalError("")
    }

    var centerXAnchor: NSLayoutXAxisAnchor {
        fatalError("")
    }

    var centerYAnchor: NSLayoutYAxisAnchor {
        fatalError("")
    }

    var firstBaselineAnchor: NSLayoutYAxisAnchor {
        fatalError("")
    }

    var lastBaselineAnchor: NSLayoutYAxisAnchor {
        fatalError("")
    }

    func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {

    }
}

class StackBuilderTests: XCTestCase {
    func testVerticalDefaultInitializers() {
        let stack = UIStackView.vertical {}
        XCTAssertEqual(stack.axis, .vertical)
        XCTAssertEqual(stack.distribution, .fill)
        XCTAssertEqual(stack.alignment, .fill)
        XCTAssertEqual(stack.spacing, UIStackView.spacingUseDefault)
    }

    func testVerticalInitializerPassThrough() {
        let stack = UIStackView.vertical(distribution: .fillEqually, alignment: .top, spacing: 100) {}
        XCTAssertEqual(stack.axis, .vertical)
        XCTAssertEqual(stack.distribution, .fillEqually)
        XCTAssertEqual(stack.alignment, .top)
        XCTAssertEqual(stack.spacing, 100)
    }

    func testHorizontalDefaultInitializers() {
        let stack = UIStackView.horizontal {}
        XCTAssertEqual(stack.axis, .horizontal)
        XCTAssertEqual(stack.distribution, .fill)
        XCTAssertEqual(stack.alignment, .fill)
        XCTAssertEqual(stack.spacing, UIStackView.spacingUseDefault)
    }

    func testHorizontalInitializerPassThrough() {
        let stack = UIStackView.horizontal(distribution: .fillEqually, alignment: .top, spacing: 100) {}
        XCTAssertEqual(stack.axis, .horizontal)
        XCTAssertEqual(stack.distribution, .fillEqually)
        XCTAssertEqual(stack.alignment, .top)
        XCTAssertEqual(stack.spacing, 100)
    }

    func testAddsSubviews() {
        let label = UILabel()
        let stack = UIStackView.vertical {
            label
        }

        XCTAssertEqual(label.superview, stack)
        XCTAssertEqual(stack.arrangedSubviews, [label])
    }

    func testCustomSpacing() {
        let label = UILabel()
        let stack = UIStackView.vertical {
            label
                .spacingAfter(10)
        }

        XCTAssertEqual(stack.customSpacing(after: label), 10)
    }

    func testIfTrue() {
        let label1 = UILabel()
        let label2 = UILabel()
        let value = true
        let stack = UIStackView.vertical {
            if value {
                label1
            } else {
                label2
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label1])
    }

    func testIfFalse() {
        let label1 = UILabel()
        let label2 = UILabel()
        let value = false
        let stack = UIStackView.vertical {
            if value {
                label1
            } else {
                label2
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label2])
    }

    func testIfTrueWithoutElse() {
        let label1 = UILabel()
        let value = true
        let stack = UIStackView.vertical {
            if value {
                label1
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label1])
    }

    func testIfFalseWithoutElse() {
        let label1 = UILabel()
        let value = false
        let stack = UIStackView.vertical {
            if value {
                label1
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [])
    }

    func testSwitchOne() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let value = TestEnum.one
        let stack = UIStackView.vertical {
            switch value {
            case .one:
                label1
            case .two:
                label2
            case .three:
                label3
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label1])
    }

    func testSwitchTwo() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let value = TestEnum.two
        let stack = UIStackView.vertical {
            switch value {
            case .one:
                label1
            case .two:
                label2
            case .three:
                label3
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label2])
    }

    func testSwitchThree() {
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let value = TestEnum.three
        let stack = UIStackView.vertical {
            switch value {
            case .one:
                label1
            case .two:
                label2
            case .three:
                label3
            }
        }

        XCTAssertEqual(stack.arrangedSubviews, [label3])
    }

    func testOptionalNil() {
        let label: UILabel? = nil
        let stack = UIStackView.vertical {
            label
        }
        XCTAssertEqual(stack.arrangedSubviews, [])
    }

    func testOptionalNotNil() {
        let label: UILabel? = UILabel()
        let stack = UIStackView.vertical {
            label
        }
        XCTAssertEqual(stack.arrangedSubviews, [label!])
    }

    func testUIViewBuilder() {
        let label = UILabel()
        let guide = UILayoutGuide()
        let view = UIView.build {
            label
            guide
        }

        XCTAssertEqual(label.superview, view)
        XCTAssertEqual(guide.owningView, view)
    }

    func testViewParent() {
        let label = UILabel()
        let view = UIView.build {
            label.constraints(.alignEdges())
        }
        let constraint = view.constraints.first
        XCTAssertTrue(constraint?.secondItem === view)
    }

    func testGuideParent() {
        let guide = UILayoutGuide()
        let label = UILabel()
        let view = UIView.build {
            UILayoutGuide.build {
                guide.constraints(.alignEdges())
                label.constraints(.alignEdges())
            }
        }
        XCTAssertEqual(guide.owningView, view)
        XCTAssertEqual(label.superview, view)
        XCTAssertEqual(view.constraints.count, 8)
        XCTAssertTrue(view.constraints.allSatisfy({ $0.secondItem is UILayoutGuide }))
    }

    func testFatalErrorsIfYouPassSomethingWrong() {
        let crashed = FatalError.withTestFatalError {
            _ = UIView.build {
                BadThing()
            }
        }
        XCTAssertTrue(crashed)
    }
}
