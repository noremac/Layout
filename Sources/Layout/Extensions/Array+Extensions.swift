import UIKit

public extension Array where Element == NSLayoutConstraint {
    /// Sets the constant of each element of the receiver to the desired
    /// constant.
    ///
    /// - Parameter constant: The new constant.
    func setConstant(_ constant: CGFloat) {
        forEach {
            $0.constant = constant
        }
    }

    /// Activates each constraint of the receiver.
    func activate() {
        NSLayoutConstraint.activate(self)
    }

    /// Deactivates each constraint of the receiver.
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
}
