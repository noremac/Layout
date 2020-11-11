import UIKit

extension Array where Element == NSLayoutConstraint {
    /// Sets the constant of each element of the receiver to the desired
    /// constant.
    ///
    /// - Parameter constant: The new constant.
    public func setConstant(_ constant: CGFloat) {
        forEach {
            $0.constant = constant
        }
    }

    /// Activates each constraint of the receiver.
    public func activate() {
        NSLayoutConstraint.activate(self)
    }

    /// Deactivates each constraint of the receiver.
    public func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}

@usableFromInline
enum FatalError {
    /// Crash. Runs `fatalError` unless overriden.
    @usableFromInline
    private(set) static var crash: (@autoclosure () -> String, StaticString, UInt) -> Void = { message, file, line in
        fatalError(message(), file: file, line: line)
    }

    #if DEBUG
        static func withTestFatalError(_ f: () -> Void) -> Bool {
            let originalCrash = crash
            defer { crash = originalCrash }
            var crashed = false
            crash = { message, _, _ in
                print("would have crashed with message:", message())
                crashed = true
            }
            f()
            return crashed
        }
    #endif
}
