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

public extension DynamicLayout.Predicate {

    static func || (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        return .init { env in
            lhs.evaluate(with: env) || rhs.evaluate(with: env)
        }
    }

    static func && (lhs: DynamicLayout<Environment>.Predicate, rhs: DynamicLayout<Environment>.Predicate) -> DynamicLayout<Environment>.Predicate {
        return .init { env in
            lhs.evaluate(with: env) && rhs.evaluate(with: env)
        }
    }
}

public extension DynamicLayout.Predicate {

    static var always: DynamicLayout<Environment>.Predicate {
        return .init { _ in true }
    }
}

public extension DynamicLayout.Predicate where Environment: DynamicLayoutTraitEnvironmentProtocol {

    static var verticallyUnspecified: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.verticalSizeClass == .unspecified
        }
    }

    static var verticallyRegular: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.verticalSizeClass == .regular
        }
    }

    static var verticallyCompact: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.verticalSizeClass == .compact
        }
    }

    static var horizontallyUnspecified: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.horizontalSizeClass == .unspecified
        }
    }

    static var horizontallyRegular: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.horizontalSizeClass == .regular
        }
    }

    static var horizontallyCompact: DynamicLayout<Environment>.Predicate {
        return .init { env in
            env.traitCollection.horizontalSizeClass == .compact
        }
    }
}

public extension DynamicLayout.Predicate where Environment: DynamicLayoutSizeEnvironmentProtocol {

    static func widthGreaterThanOrEqualTo(_ dimension: CGFloat) -> DynamicLayout<Environment>.Predicate {
        return .init { env in
            return env.size.width >= dimension
        }
    }

    static var tall: DynamicLayout<Environment>.Predicate {
        return .init { env in
            return env.size.height > env.size.width
        }
    }

    static var wide: DynamicLayout<Environment>.Predicate {
        return .init { env in
            return env.size.width >= env.size.height
        }
    }
}