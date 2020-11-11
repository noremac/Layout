import UIKit
import XCTest

func XCTAssertEqualConstraints<S>(_ sut: S, _ desired: [NSLayoutConstraint], file: StaticString = #file, line: UInt = #line) where S: Collection, S.Element == NSLayoutConstraint {
    guard desired.count == sut.count else {
        return XCTFail("Constraint count \(sut.count) does not match \(desired.count)", file: file, line: line)
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
