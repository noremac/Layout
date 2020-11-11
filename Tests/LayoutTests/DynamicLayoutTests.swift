import UIKit
import XCTest

@testable import Layout

class DynamicLayoutTests: XCTestCase {
    var parentView: UIView!
    var view: UIView!

    override func setUp() {
        super.setUp()
        ConstraintGroup.debugConstraints = false
        parentView = .init()
        view = .init()
        parentView.addSubview(view)
    }

    override func tearDown() {
        ConstraintGroup.debugConstraints = true
        super.tearDown()
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
                view.applyConstraints(.leading())
            }
        }
        XCTAssertTrue(crashed)
    }

    func testGlobalConstraints() {
        let sut = DynamicLayout<Void>()
        sut.configure { _ in
            view.makeConstraints(.leading())
        }
        sut.update(environment: ())
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
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
                view.makeConstraints(.leading())
            } otherwise: {
                view.makeConstraints(.trailing())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.trailing()))
    }

    func testPredicateWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(.init { $0 }) {
                view.makeConstraints(.leading())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testClosureOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when({ $0 }) {
                view.makeConstraints(.leading())
            } otherwise: {
                view.makeConstraints(.trailing())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.trailing()))
    }

    func testClosureWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when({ $0 }) {
                view.makeConstraints(.leading())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testEquatableOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(true) {
                view.makeConstraints(.leading())
            } otherwise: {
                view.makeConstraints(.trailing())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.trailing()))
    }

    func testEquatableWithoutOtherwise() {
        let sut = DynamicLayout<Bool>()
        sut.configure { config in
            config.when(true) {
                view.makeConstraints(.leading())
            }
        }
        sut.update(environment: true)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: false)
        XCTAssertEqualConstraints(sut.activeConstraints, [])
    }

    func testMoreComplexConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        sut.configure { config in
            config.when(.horizontallyRegular) {
                view.makeConstraints(.top())

                config.when(.width(is: >=, 1024)) {
                    view.makeConstraints(.leading())
                } otherwise: {
                    view.makeConstraints(.trailing())
                }
            } otherwise: {
                view.makeConstraints(.bottom())
            }
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.bottom()))
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.top(), .leading()))
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1023, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.top(), .trailing()))
    }

    func testMultipleTopLevelConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        sut.configure { ctx in
            ctx.when(.horizontallyRegular) {
                view.makeConstraints(.top())
            } otherwise: {
                view.makeConstraints(.bottom())
            }

            ctx.when(.width(is: >=, 1024)) {
                view.makeConstraints(.leading())
            } otherwise: {
                view.makeConstraints(.trailing())
            }
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.top(), .leading()))

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1024, height: 1024)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.bottom(), .leading()))

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.top(), .trailing()))

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.bottom(), .trailing()))
    }

    func testOtherCaseWithoutDirectConstraints() {
        let sut = DynamicLayout<Int>()
        sut.configure { config in
            config.when({ $0 < 10 }) {
                view.makeConstraints(.leading())
            } otherwise: {
                config.when(10) {
                    view.makeConstraints(.top())
                } otherwise: {
                    view.makeConstraints(.bottom())
                }
            }
        }
        sut.update(environment: 1)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.leading()))
        sut.update(environment: 10)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.top()))
        sut.update(environment: 11)
        XCTAssertEqualConstraints(sut.activeConstraints, view.applyConstraints(.bottom()))
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
                    view.makeConstraints(
                        .size(.init(width: 100, height: 100))
                    )
                }

                config.when(true) {
                    for view in views {
                        view.makeConstraints(
                            .center()
                        )
                    }
                } otherwise: {
                    for view in views {
                        view.makeConstraints(
                            .leading(),
                            .top()
                        )
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
