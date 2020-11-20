import UIKit

public extension DynamicLayout {
    final class Configuration {
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

public extension DynamicLayout.Configuration where Environment: Equatable {
    func when(_ environment: Environment, _ when: () -> Void, otherwise: () -> Void) {
        self.when(.init({ $0 == environment }), when, otherwise: otherwise)
    }

    func when(_ environment: Environment, _ when: () -> Void) {
        self.when(.init({ $0 == environment }), when, otherwise: {})
    }
}
