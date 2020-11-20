import UIKit
import XCTest

@testable import Layout

class DynamicLayoutTests: XCTestCase {
    var parentView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        parentView = .init()
        view = .init()
        parentView.addSubview(view)
    }

    func testConfigureOnlyCalledOnce() {
        let sut = DynamicLayout<Bool>()
        sut.configure { _ in }
        let crashed = FatalError.withTestFatalError {
            sut.configure { _ in }
        }
        XCTAssertTrue(crashed)
    }

    func testApplyConstraintsFatalError() {
        let crashed = FatalError.withTestFatalError {
            let sut = DynamicLayout<Bool>()
            sut.configure { _ in
                view.applyConstraints {
                    Leading()
                }
            }
        }
        XCTAssertTrue(crashed)
    }

    func testGlobalConstraints() {
        let sut = DynamicLayout<Void>()
        sut.configure { _ in
            view.makeConstraints {
                Leading()
            }
        }
        sut.update(environment: ())
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
    }

    func testGlobalActions() {
        var called = false
        let sut = DynamicLayout<Void>()
        sut.configure { config in
            config.addAction {
                called = true
            }
        }
        sut.update(environment: ())
        XCTAssertTrue(called)
    }

    func testPredicateOtherwiseConstraints() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(.init { $0 }) {
                view.makeConstraints {
                    Leading()
                }
            } otherwise: {
                view.makeConstraints {
                    Trailing()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Trailing() })
    }

    func testPredicateWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(.init { $0 }) {
                view.makeConstraints {
                    Leading()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testClosureOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when({ $0 }) {
                view.makeConstraints {
                    Leading()
                }
            } otherwise: {
                view.makeConstraints {
                    Trailing()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Trailing() })
    }

    func testClosureWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when({ $0 }) {
                view.makeConstraints {
                    Leading()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testEquatableOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(true) {
                view.makeConstraints {
                    Leading()
                }
            } otherwise: {
                view.makeConstraints {
                    Trailing()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Trailing() })
    }

    func testEquatableWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(true) {
                view.makeConstraints {
                    Leading()
                }
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testMoreComplexConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        sut.configure { config in
            config.when(.horizontallyRegular) {
                view.makeConstraints {
                    Top()
                }

                config.when(.width(is: >=, 1024)) {
                    view.makeConstraints {
                        Leading()
                    }
                } otherwise: {
                    view.makeConstraints {
                        Trailing()
                    }
                }
            } otherwise: {
                view.makeConstraints {
                    Bottom()
                }
            }
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Bottom() })
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Top(); Leading() })
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1023, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Top(); Trailing() })
    }

    func testMultipleTopLevelConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        sut.configure { ctx in
            ctx.when(.horizontallyRegular) {
                view.makeConstraints {
                    Top()
                }
            } otherwise: {
                view.makeConstraints {
                    Bottom()
                }
            }

            ctx.when(.width(is: >=, 1024)) {
                view.makeConstraints {
                    Leading()
                }
            } otherwise: {
                view.makeConstraints {
                    Trailing()
                }
            }
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Top(); Leading() })

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Bottom(); Leading() })

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Top(); Trailing() })

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Bottom(); Trailing() })
    }

    func testOtherCaseWithoutDirectConstraints() {
        let sut = DynamicLayout<Int>()
        sut.configure { config in
            config.when({ $0 < 10 }) {
                view.makeConstraints {
                    Leading()
                }
            } otherwise: {
                config.when(10) {
                    view.makeConstraints {
                        Top()
                    }
                } otherwise: {
                    view.makeConstraints {
                        Bottom()
                    }
                }
            }
        }
        sut.update(environment: 1)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Leading() })
        sut.update(environment: 10)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Top() })
        sut.update(environment: 11)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints { Bottom() })
    }

    func testBasicActions() {
        var x = 0
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(true) {
                config.addAction {
                    x = 1
                }
            } otherwise: {
                config.addAction {
                    x = 2
                }
            }
        }
        XCTAssertEqual(x, 0)
        sut.update(environment: true)
        XCTAssertEqual(x, 1)
        sut.update(environment: false)
        XCTAssertEqual(x, 2)
    }

    func testMultipleTopLevelConditionsActions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        var sizeClass = UIUserInterfaceSizeClass.unspecified
        var biggerThan1024 = false

        sut.configure { config in
            config.when(.horizontallyRegular) {
                config.addAction {
                    sizeClass = .regular
                }
            } otherwise: {
                config.addAction {
                    sizeClass = .compact
                }
            }

            config.when(.width(is: >=, 1024)) {
                config.addAction {
                    biggerThan1024 = true
                }
            } otherwise: {
                config.addAction {
                    biggerThan1024 = false
                }
            }
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqual(sizeClass, .regular)
        XCTAssertTrue(biggerThan1024)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqual(sizeClass, .compact)
        XCTAssertTrue(biggerThan1024)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 10, height: 10)))
        XCTAssertEqual(sizeClass, .regular)
        XCTAssertFalse(biggerThan1024)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 10, height: 10)))
        XCTAssertEqual(sizeClass, .compact)
        XCTAssertFalse(biggerThan1024)
    }

    func testUpdatePerformance() {
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            let sut = DynamicLayout<Bool>()
            let parentView = UIView()
            let views = (1...10000).map({ _ in UIView() })
            views.forEach({ parentView.addSubview($0) })
            sut.configure { config in
                for view in views {
                    view.makeConstraints {
                        Size(width: 100, height: 100)
                    }
                }

                config.when(true) {
                    for view in views {
                        view.makeConstraints {
                            Center()
                        }
                    }
                } otherwise: {
                    for view in views {
                        view.makeConstraints {
                            Leading()
                            Top()
                        }
                    }
                }
            }

            startMeasuring()
            sut.update(environment: true)
            sut.update(environment: false)
            stopMeasuring()
        })
    }
}
