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

func XCTAssertEqualConstraints<S>(_ desired: [NSLayoutConstraint], _ sut: S, file: StaticString = #file, line: UInt = #line) where S: Collection, S.Element == NSLayoutConstraint {
    guard desired.count == sut.count else {
        return XCTFail("Constraint counts do not match.\nDesired: \(desired)\nReceived: \(sut)", file: file, line: line)
    }

    let missingConstraints = desired.filter { c1 in
        !sut.contains(where: { c2 in c1.isEqualToConstraint(c2) })
    }

    guard missingConstraints.isEmpty else {
        return XCTFail("Could not find constraint\(missingConstraints.count > 1 ? "s" : "") matching: \(missingConstraints)", file: file, line: line)
    }
}

extension NSLayoutConstraint {
    func isEqualToConstraint(_ otherConstraint: NSLayoutConstraint) -> Bool {
        firstItem === otherConstraint.firstItem
            && secondItem === otherConstraint.secondItem
            && firstAttribute == otherConstraint.firstAttribute
            && secondAttribute == otherConstraint.secondAttribute
            && relation == otherConstraint.relation
            && multiplier == otherConstraint.multiplier
            && constant == otherConstraint.constant
            && priority == otherConstraint.priority
            && identifier == otherConstraint.identifier
            && isActive == otherConstraint.isActive
    }
}
