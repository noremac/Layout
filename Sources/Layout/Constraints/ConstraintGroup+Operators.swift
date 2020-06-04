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

// swiftlint:disable static_operator

precedencegroup ConstraintGroupPriorityAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: ConstraintGroupIdentifierAssignment
}

infix operator ~: ConstraintGroupPriorityAssignment

/// Sets the priority of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint group.
///   - rhs: The priority.
/// - Returns: A new constraint group whose priority has been modified.
public func ~ (lhs: ConstraintGroup, rhs: UILayoutPriority) -> ConstraintGroup {
    var new = lhs
    new.priority = rhs
    return new
}

/// Sets the priority of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint group.
///   - rhs: The priority.
/// - Returns: A new constraint group whose priority has been modified.
public func ~ (lhs: ConstraintGroup, rhs: Float) -> ConstraintGroup {
    var new = lhs
    new.priority = .init(rawValue: rhs)
    return new
}

precedencegroup ConstraintGroupIdentifierAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
}

infix operator <-: ConstraintGroupIdentifierAssignment

/// Sets the identifier of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint group.
///   - rhs: The identifier.
/// - Returns: A new constraint group whose identifier has been modified.
public func <- (lhs: ConstraintGroup, rhs: String?) -> ConstraintGroup {
    var new = lhs
    new.identifier = rhs
    return new
}
