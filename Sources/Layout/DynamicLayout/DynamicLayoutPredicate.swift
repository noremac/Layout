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

extension DynamicLayout.Predicate {
    /// Evaluates the receiver with the given environment.
    ///
    /// - Parameter environment: An `Environment` value.
    /// - Returns: The vale of the predicate with the given environment.
    public func evaluate(with environment: Environment) -> Bool {
        predicate(environment)
    }
}

extension DynamicLayout.Predicate {
    /// Creates a new composite `Predicate` that `or`s together two others.
    ///
    /// - Parameters:
    ///   - lhs: The first `Predicate`.
    ///   - rhs: The second `Predicate`.
    /// - Returns: A new composite `Predicate` that `or`s together two others.
    public static func || (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
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
    public static func && (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        .init { env in
            lhs.evaluate(with: env) && rhs.evaluate(with: env)
        }
    }

    /// Creates a new `Predicate` that negates the given `Predicate`.
    ///
    /// - Parameter predicate: The `Predicate` to negate.
    /// - Returns: A new `Predicate` that negates the given `Predicate`.
    public static prefix func ! (predicate: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        .init { env in
            !predicate.evaluate(with: env)
        }
    }
}

extension DynamicLayout.Predicate {
    /// Returns a `Predicate` that always evaluates to `true`.
    public static var always: DynamicLayout<Environment>.Predicate {
        .init { _ in true }
    }
}

extension DynamicLayout.Predicate where Environment: DynamicLayoutTraitEnvironmentProtocol {
    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is unspecified.
    public static var verticallyUnspecified: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .unspecified
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is regular.
    public static var verticallyRegular: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .regular
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// vertical size class is compact.
    public static var verticallyCompact: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.verticalSizeClass == .compact
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is unspecified.
    public static var horizontallyUnspecified: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .unspecified
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is regular.
    public static var horizontallyRegular: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .regular
        }
    }

    /// Returns a `Predicate` that is `true` if the `Environment`'s current
    /// horizontal size class is compact.
    public static var horizontallyCompact: DynamicLayout<Environment>.Predicate {
        .init { env in
            env.traitCollection.horizontalSizeClass == .compact
        }
    }
}

extension DynamicLayout.Predicate where Environment: DynamicLayoutSizeEnvironmentProtocol {
    /// Returns a `Predicate` that is `true` when the given closure is `true`.
    ///
    /// - Parameters:
    ///   - f: The closure.
    ///   - width: The `Environment`'s width.
    ///   - other: The "other" value.
    /// - Returns: A `Predicate` that is `true` when the given closure is
    ///   `true`.
    public static func width(is f: @escaping (_ width: CGFloat, _ other: CGFloat) -> Bool, _ other: CGFloat) -> DynamicLayout.Predicate {
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
    public static func height(is f: @escaping (_ height: CGFloat, _ other: CGFloat) -> Bool, _ other: CGFloat) -> DynamicLayout.Predicate {
        .init { env in
            f(env.size.height, other)
        }
    }
}
