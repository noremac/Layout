import UIKit

// swiftlint:disable static_operator

precedencegroup ConstraintGeneratorPriorityAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: ConstraintGeneratorIdentifierAssignment
}

infix operator ~: ConstraintGeneratorPriorityAssignment

/// Sets the priority of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint generator.
///   - rhs: The priority.
/// - Returns: A new constraint generator whose priority has been modified.
public func ~ (lhs: MultipleConstraintGenerator, rhs: UILayoutPriority) -> MultipleConstraintGenerator {
    var new = lhs
    new.priority = rhs
    return new
}

/// Sets the priority of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint generator.
///   - rhs: The priority.
/// - Returns: A new constraint generator whose priority has been modified.
public func ~ (lhs: MultipleConstraintGenerator, rhs: Float) -> MultipleConstraintGenerator {
    var new = lhs
    new.priority = .init(rawValue: rhs)
    return new
}

precedencegroup ConstraintGeneratorIdentifierAssignment {
    associativity: left
    lowerThan: ComparisonPrecedence
}

infix operator <-: ConstraintGeneratorIdentifierAssignment

/// Sets the identifier of a `ConstraintGroup`.
///
/// - Parameters:
///   - lhs: The constraint generator.
///   - rhs: The identifier.
/// - Returns: A new constraint generator whose identifier has been modified.
public func <- (lhs: MultipleConstraintGenerator, rhs: String?) -> MultipleConstraintGenerator {
    var new = lhs
    new.identifier = rhs
    return new
}
