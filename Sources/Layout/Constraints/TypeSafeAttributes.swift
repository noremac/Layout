import UIKit

public struct XAttribute {
    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }
}

public extension XAttribute {
    static let left = XAttribute(.left)

    static let right = XAttribute(.right)

    static let leading = XAttribute(.leading)

    static let trailing = XAttribute(.trailing)

    static let centerX = XAttribute(.centerX)
}

public struct YAttribute {
    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }
}

public extension YAttribute {
    static let top = YAttribute(.top)

    static let bottom = YAttribute(.bottom)

    static let firstBaseline = YAttribute(.firstBaseline)

    static let lastBaseline = YAttribute(.lastBaseline)

    static let centerY = YAttribute(.centerY)
}

public struct DimensionAttribute {
    public let attribute: NSLayoutConstraint.Attribute

    public init(_ attribute: NSLayoutConstraint.Attribute) {
        self.attribute = attribute
    }
}

public extension DimensionAttribute {
    static let width = DimensionAttribute(.width)

    static let height = DimensionAttribute(.height)
}
