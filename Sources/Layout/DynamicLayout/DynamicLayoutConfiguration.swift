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

extension DynamicLayout {
    public final class Configuration {
        var currentContext: DynamicLayout.Context {
            didSet {
                _globalConstraintContainer = currentContext
            }
        }

        init(_ currentContext: DynamicLayout<Environment>.Context) {
            self.currentContext = currentContext
        }
    }
}

public extension DynamicLayout.Configuration {
    func addAction(_ action: @escaping (Environment) -> Void) {
        currentContext.actions.append(action)
    }

    func addAction(_ action: @escaping () -> Void) {
        currentContext.actions.append({ _ in action() })
    }

    func when(_ predicate: DynamicLayout.Predicate, _ when: () -> Void, otherwise: () -> Void) {
        let whenCtx = DynamicLayout.Context(predicate: predicate)
        let otherwiseCtx = DynamicLayout.Context(predicate: !predicate)
        let cc = currentContext
        currentContext = whenCtx
        when()
        currentContext = otherwiseCtx
        otherwise()
        if otherwiseCtx.hasConstraintsOrActions {
            whenCtx.otherwise = otherwiseCtx
        }
        currentContext = cc
        currentContext.children.append(whenCtx)
    }

    func when(_ predicate: DynamicLayout.Predicate, _ when: () -> Void) {
        self.when(predicate, when, otherwise: {})
    }

    func when(_ predicate: @escaping (_ env: Environment) -> Bool, _ when: () -> Void, otherwise: () -> Void) {
        self.when(.init(predicate), when, otherwise: otherwise)
    }

    func when(_ predicate: @escaping (_ env: Environment) -> Bool, _ when: () -> Void) {
        self.when(.init(predicate), when, otherwise: {})
    }
}

extension DynamicLayout.Configuration where Environment: Equatable {
    func when(_ environment: Environment, _ when: () -> Void, otherwise: () -> Void) {
        self.when(.init({ $0 == environment }), when, otherwise: otherwise)
    }

    func when(_ environment: Environment, _ when: () -> Void) {
        self.when(.init({ $0 == environment }), when, otherwise: {})
    }
}
