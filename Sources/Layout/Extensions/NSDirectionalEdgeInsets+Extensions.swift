import UIKit

extension NSDirectionalEdgeInsets: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public init(integerLiteral value: Int) {
        let float = CGFloat(value)
        self.init(top: float, leading: float, bottom: float, trailing: float)
    }

    public init(floatLiteral value: Double) {
        let float = CGFloat(value)
        self.init(top: float, leading: float, bottom: float, trailing: float)
    }
}
