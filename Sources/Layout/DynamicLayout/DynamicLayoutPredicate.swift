import UIKit

public extension DynamicLayout.Predicate {
    /// Evaluates the receiver with the given environment.
    ///
    /// - Parameter environment: An `Environment` value.
    /// - Returns: The vale of the predicate with the given environment.
    func evaluate(with environment: Environment) -> Bool {
        predicate(environment)
    }
}

public extension DynamicLayout.Predicate {
    /// Creates a new composite `Predicate` that `or`s together two others.
    ///
    /// - Parameters:
    ///   - lhs: The first `Predicate`.
    ///   - rhs: The second `Predicate`.
    /// - Returns: A new composite `Predicate` that `or`s together two others.
    static func || (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        .init { env in
            lhs.evaluate(with: env) || rhs.evaluate(with: env)
        }
    }

    /// Creates a new composite `Predicate` that `and`s together two others.
    ///
    /// - Parameters:
    ///   - lhs: The first `Predicate`.
    ///   - rhs: The second `Predicate`.
    /// - Returns: A new composite `Predicate` that `and`s together two others.
    static func && (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        .init { env in
            lhs.evaluate(with: env) && rhs.evaluate(with: env)
        }
    }

    /// Creates a new `Predicate` that negates the given `Predicate`.
    ///
    /// - Parameter predicate: The `Predicate` to negate.
    /// - Returns: A new `Predicate` that negates the given `Predicate`.
    static prefix func ! (predicate: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        .init { env in
            !predicate.evaluate(with: env)
        }
    }
}

public extension DynamicLayout.Predicate {
    /// Returns a `Predicate` that always evaluates to `true`.
    static var always: DynamicLayout<Environment>.Predicate {
        .init { _ in true }
    }
}

public extension DynamicLayout.Predicate where Environment: DynamicLayoutTraitEnvironmentProtocol {
    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is unspecified.
    static var verticallyUnspecified: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .unspecified
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is regular.
    static var verticallyRegular: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .regular
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is compact.
    static var verticallyCompact: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .compact
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is unspecified.
    static var horizontallyUnspecified: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .unspecified
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is regular.
    static var horizontallyRegular: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .regular
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is compact.
    static var horizontallyCompact: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .compact
        }
    }
}

public extension DynamicLayout.Predicate where Environment: DynamicLayoutSizeEnvironmentProtocol {
    /// Returns a `Predicate` that is `true` when the given closure is `true`.
    ///
    /// - Parameters:
    ///   - f: The closure.
    ///   - width: The `Environment`'s width.
    ///   - other: The "other" value.
    /// - Returns: A `Predicate` that is `true` when the given closure is
    ///   `true`.
    static func width(is f: @escaping (_ width: CGFloat, _ other: CGFloat) -> Bool, _ other: CGFloat) -> DynamicLayout.Predicate {
        .init { env in
            f(env.size.width, other)
        }
    }

    /// Returns a `Predicate` that is `true` when the given closure is `true`.
    ///
    /// - Parameters:
    ///   - f: The closure.
    ///   - height: The `Environment`'s height.
    ///   - other: The "other" value.
    /// - Returns: A `Predicate` that is `true` when the given closure is
    ///   `true`.
    static func height(is f: @escaping (_ height: CGFloat, _ other: CGFloat) -> Bool, _ other: CGFloat) -> DynamicLayout.Predicate {
        .init { env in
            f(env.size.height, other)
        }
    }
}
