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
    var sut: DynamicLayout<Bool>!

    override func setUp() {
        super.setUp()
        ConstraintGroup.debugConstraints = false
        parentView = .init()
        view = .init()
        parentView.addSubview(view)
        sut = .init()
    }

    override func tearDown() {
        ConstraintGroup.debugConstraints = true
        super.tearDown()
    }

    func testActivatesConstraintsAppropriately() {
        sut.addConstraints { ctx in
            ctx.addConstraints(for: view, .setSize(.init(width: 1, height: 1)))

            ctx.when(true, { ctx in
                ctx.addConstraints(for: view, .center())
            }, otherwise: { ctx in
                ctx.addConstraints(for: view, .align(.leading), .align(.top))
            })
        }

        let globalConstraints = view.applyConstraints(.setSize(.init(width: 1, height: 1)))
        let trueConstraints = view.applyConstraints(.center()) + globalConstraints
        let falseConstraints = view.applyConstraints(.align(.leading), .align(.top)) + globalConstraints

        XCTAssertTrue(sut.activeConstraints.isEmpty)
        sut.updateActiveConstraints(with: true)
        XCTAssertEqualConstraints(trueConstraints, sut.activeConstraints)
        sut.updateActiveConstraints(with: false)
        XCTAssertEqualConstraints(falseConstraints, sut.activeConstraints)
    }
}
