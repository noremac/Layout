import SwiftUI
import UIKit
import XCTest

@testable import Layout

enum TestEnum {
    case one
    case two
    case three
}

extension UILabel {
    convenience init(int: Int) {
        self.init(frame: .zero)
        text = "\(int)"
    }
}

final class BadConstrainableItem: ConstrainableItem {
    var parentView: UIView?

    func setTranslatesAutoresizingMaskIntoConstraintsFalseIfNecessary() {}
}

final class StackBuilderTests: XCTestCase {
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
            label.constraints {
                AlignEdges()
            }
        }
        let constraint = view.constraints.first
        XCTAssertTrue(constraint?.secondItem === view)
    }

    func testGuideParent() {
        let guide = UILayoutGuide()
        let label = UILabel()
        let view = UIView.build {
            UILayoutGuide.build {
                guide.constraints {
                    AlignEdges()
                }
                label.constraints {
                    AlignEdges()
                }
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
                BadConstrainableItem()
            }
        }
        XCTAssertTrue(crashed)
    }

    func testArray() {
        let view = UIStackView.vertical {
            (0..<100).map(UILabel.init(int:))
        }
        XCTAssertEqual(view.arrangedSubviews.count, 100)
    }

    func testForEach() {
        let view = UIStackView.vertical {
            for i in 0..<100 {
                UILabel(int: i)
            }
        }
        XCTAssertEqual(view.arrangedSubviews.count, 100)
    }

    func testAvailabilityAvailable() throws {
        let view = UIStackView.vertical {
            if #available(iOS 13, *) {
                UILabel()
            } else {
                UITextField()
            }
        }
        let item = try XCTUnwrap(view.arrangedSubviews.first)
        XCTAssertTrue(item is UILabel)
    }

    func testAvailabilityNotAvailable() throws {
        let view = UIStackView.vertical {
            if #available(iOS 9999, *) {
                UILabel()
            } else {
                UITextField()
            }
        }
        let item = try XCTUnwrap(view.arrangedSubviews.first)
        XCTAssertTrue(item is UITextField)
    }
}
