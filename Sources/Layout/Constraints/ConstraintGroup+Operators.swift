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
