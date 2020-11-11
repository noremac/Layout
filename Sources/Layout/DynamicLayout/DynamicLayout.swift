import UIKit

@usableFromInline
protocol _GlobalConstraintContainer {
    func addConstraints(_ constraints: [NSLayoutConstraint])
}

@usableFromInline
var _globalConstraintContainer: _GlobalConstraintContainer?

/// A class for creating, storing, and activating `NSLayoutConstraint`s based on
/// arbitrary predicates.
///
/// `Context`'s are stored as a tree and thus may be nested. A child `Context`'s
/// `Predicate` is only evaluated if its parent's `Predicate` evaluates to
/// `true`.
///
/// The initial `Context` received in the `configure` block is always `true`.
/// Constraints that should always be active regardless of any state may
/// be added there.
public class DynamicLayout<Environment> {
    /// A struct for defining a condition to be met for constraints to be
    /// activated.
    public struct Predicate {
        /// The predicate.
        public let predicate: (Environment) -> Bool

        /// Initializes a new `Predicate` with the given closure.
        ///
        /// - Parameter predicate: The closure.
        public init(_ predicate: @escaping (Environment) -> Bool) {
            self.predicate = predicate
        }
    }

    /// A struct for holding a `Predicate` and its associated
    /// `NSLayoutConstraint`s.
    final class Context: _GlobalConstraintContainer {
        var predicate: Predicate

        var constraints: [NSLayoutConstraint] = []

        var actions: [(Environment) -> Void] = []

        var children: [Context] = []

        var otherwise: Context?

        init(predicate: Predicate) {
            self.predicate = predicate
        }

        /// Inspects self and children/other for constraints or actions.
        var hasConstraintsOrActions: Bool {
            if !constraints.isEmpty || !actions.isEmpty {
                return true
            }
            if children.contains(where: { $0.hasConstraintsOrActions }) {
                return true
            }
            return otherwise?.hasConstraintsOrActions ?? false
        }

        func activeContexts(for environment: Environment) -> [DynamicLayout.Context] {
            if predicate.evaluate(with: environment) {
                return children.reduce(into: [self], { $0 += $1.activeContexts(for: environment) })
            }
            return otherwise?.activeContexts(for: environment) ?? []
        }

        func addConstraints(_ constraints: [NSLayoutConstraint]) {
            self.constraints += constraints
        }
    }

    var hasBeenConfigured = false

    var mainContext: Context = .init(predicate: .always)

    var activeConstraints: Set<NSLayoutConstraint> = []

    /// Initializes a DynamicLayout.
    public init() {}

    /// Add constraints here. The closure receives the main `Context` whose
    /// `Predicate` will always evaluate to `true`. From here, create as many
    /// `Context`s as needed and nest them as desired.
    ///
    /// - Parameters:
    ///   - main: The closure where constraints are configured.
    ///   - ctx: The main `Context` whose `Predicate` is always `true`.
    ///
    /// - Note: You may add constraints that should always be active regardless
    ///   of any other condition to the main `Context`. These constraints will
    ///   not be activated until the first call to `updateActiveConstraints`.
    ///
    /// - Attention: A `fatalError` will be hit if this method is called more
    ///   than once.
    public func configure(file: StaticString = #file, line: UInt = #line, _ main: (_ configuration: Configuration) -> Void) {
        guard !hasBeenConfigured else {
            return FatalError.crash("\(#function) should only be called once", file, line)
        }
        hasBeenConfigured = true
        _globalConstraintContainer = mainContext
        main(Configuration(mainContext))
        _globalConstraintContainer = nil
    }

    /// Walks the tree of `Context`s and activates all the constraints whose
    /// `Predicate`s are `true` in the given `Environment`.
    ///
    /// - Parameter environment: The `Environment` to use for evaluation.
    public func update(environment: Environment) {
        let contexts = mainContext.activeContexts(for: environment)
        let (newConstraints, actions) = contexts.reduce(into: ([NSLayoutConstraint](), [(Environment) -> Void]())) { result, context in
            result.0.append(contentsOf: context.constraints)
            result.1.append(contentsOf: context.actions)
        }
        let newSet = Set(newConstraints)
        var constraintsToDeactivate = [NSLayoutConstraint]()
        var constraintsToActivate = [NSLayoutConstraint]()
        for newConstraint in newSet {
            if !activeConstraints.contains(newConstraint) {
                constraintsToActivate.append(newConstraint)
            }
        }
        for oldConstraint in activeConstraints {
            if !newSet.contains(oldConstraint) {
                constraintsToDeactivate.append(oldConstraint)
            }
        }
        constraintsToDeactivate.deactivate()
        constraintsToActivate.activate()
        activeConstraints = newSet
        actions.forEach { $0(environment) }
    }
}
