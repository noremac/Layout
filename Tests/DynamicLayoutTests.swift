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

    func testDoesNotImmediatelyActivateGlobalConstraints() {
        let sut = DynamicLayout<Bool>()
        sut.configure { ctx in
            ctx.addConstraints(view.makeConstraints(.center()))
        }
        XCTAssertTrue(sut.activeConstraints.isEmpty)
        sut.update(environment: true)
        XCTAssertEqualConstraints(view.applyConstraints(.center()), sut.activeConstraints)
    }

    func testEvaluatesActions() {
        let sut = DynamicLayout<Bool>()
        var x = 0
        sut.configure { ctx in
            ctx.when(true, { ctx in
                ctx.addAction { _ in x = 1 }
            }, otherwise: { ctx in
                ctx.addAction { _ in x = 2 }
            })
        }
        XCTAssertEqual(0, x)
        sut.update(environment: true)
        XCTAssertEqual(1, x)
        sut.update(environment: false)
        XCTAssertEqual(2, x)
    }

    func testMoreComplexConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        let compact = view.makeConstraints(.align(.top))
        let regular = view.makeConstraints(.align(.bottom))
        let greaterThan1024 = view.makeConstraints(.align(.leading))
        let lessThan1024 = view.makeConstraints(.align(.trailing))
        sut.configure { ctx in
            ctx.when(.horizontallyRegular, { ctx in
                ctx.addConstraints(regular)

                ctx.when(.width(is: >=, 1_024), { ctx in
                    ctx.addConstraints(greaterThan1024)
                }, otherwise: { ctx in
                    ctx.addConstraints(lessThan1024)
                })
            }, otherwise: { ctx in
                ctx.addConstraints(compact)
            })
        }

        compact.activate()
        regular.activate()
        greaterThan1024.activate()
        lessThan1024.activate()

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqualConstraints(compact, sut.activeConstraints)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqualConstraints(regular + greaterThan1024, sut.activeConstraints)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1_023, height: 1_024)))
        XCTAssertEqualConstraints(regular + lessThan1024, sut.activeConstraints)
    }

    func testMultipleTopLevelConditions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        let compact = view.makeConstraints(.align(.top))
        let regular = view.makeConstraints(.align(.bottom))
        let greaterThan1024 = view.makeConstraints(.align(.leading))
        let lessThan1024 = view.makeConstraints(.align(.trailing))

        sut.configure { ctx in
            ctx.when(.horizontallyRegular, { ctx in
                ctx.addConstraints(regular)
            }, otherwise: { ctx in
                ctx.addConstraints(compact)
            })

            ctx.when(.width(is: >=, 1_024), { ctx in
                ctx.addConstraints(greaterThan1024)
            }, otherwise: { ctx in
                ctx.addConstraints(lessThan1024)
            })
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqualConstraints(regular + greaterThan1024, sut.activeConstraints)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqualConstraints(compact + greaterThan1024, sut.activeConstraints)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(regular + lessThan1024, sut.activeConstraints)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 10, height: 10)))
        XCTAssertEqualConstraints(compact + lessThan1024, sut.activeConstraints)
    }

    func testMultipleTopLevelConditionsActions() {
        let sut = DynamicLayout<DynamicLayoutTraitAndSizeEnvironment>()
        var sizeClass = UIUserInterfaceSizeClass.unspecified
        var biggerThan1024 = false

        sut.configure { ctx in
            ctx.when(.horizontallyRegular, { ctx in
                ctx.addAction { _ in
                    sizeClass = .regular
                }
            }, otherwise: { ctx in
                ctx.addAction { _ in
                    sizeClass = .compact
                }
            })

            ctx.when(.width(is: >=, 1_024), { ctx in
                ctx.addAction { _ in
                    biggerThan1024 = true
                }
            }, otherwise: { ctx in
                ctx.addAction { _ in
                    biggerThan1024 = false
                }
            })
        }

        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqual(sizeClass, .regular)
        XCTAssertEqual(biggerThan1024, true)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 1_024, height: 1_024)))
        XCTAssertEqual(sizeClass, .compact)
        XCTAssertEqual(biggerThan1024, true)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .regular), size: CGSize(width: 10, height: 10)))
        XCTAssertEqual(sizeClass, .regular)
        XCTAssertEqual(biggerThan1024, false)
        sut.update(environment: .init(traitCollection: .init(horizontalSizeClass: .compact), size: CGSize(width: 10, height: 10)))
        XCTAssertEqual(sizeClass, .compact)
        XCTAssertEqual(biggerThan1024, false)
    }

    func testUpdatePerformance() {
        measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            let sut = DynamicLayout<Bool>()
            let parentView = UIView()
            let views = (1...10_000).map({ _ in UIView() })
            views.forEach({ parentView.addSubview($0) })
            sut.configure { ctx in
                for view in views {
                    ctx.addConstraints(
                        view.makeConstraints(
                            .setSize(to: .init(width: 100, height: 100))
                        )
                    )
                }

                ctx.when(true, { ctx in
                    for view in views {
                        ctx.addConstraints(
                            view.makeConstraints(
                                .center()
                            )
                        )
                    }
                }, otherwise: { ctx in
                    for view in views {
                        ctx.addConstraints(
                            view.makeConstraints(
                                .align(.leading),
                                .align(.top)
                            )
                        )
                    }
                })
            }

            startMeasuring()
            sut.update(environment: true)
            sut.update(environment: false)
            stopMeasuring()
        })
    }
}
