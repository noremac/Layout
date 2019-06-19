import Layout
import UIKit

let view = UIView()
let container = UIView()
let button = UIButton()
let otherButton = UIButton()

view.addSubview(container)
view.addSubview(button)
view.addSubview(otherButton)

// All of these lines...
_ = button.makeConstraints(
    .leading(.equal, to: otherButton, attribute: .leading, multiplier: 1, constant: 0),
    .leading(.equal, to: otherButton, attribute: .leading, multiplier: 1),
    .leading(.equal, to: otherButton, attribute: .leading),
    .leading(.equal, to: otherButton),
    .leading(.equal),
    .leading()
)

// ...are equivalent to this...

NSLayoutConstraint(
    item: button,
    attribute: .leading,
    relatedBy: .equal,
    toItem: button.superview,
    attribute: .leading,
    multiplier: 1,
    constant: 0
)

// ... and this.
button.leadingAnchor.constraint(equalTo: view.leadingAnchor)

// Alignment operators examples
container.makeConstraints(
    .left(),
    .right(),
    .leading(),
    .trailing(),
    .centerX(),
    .centerY(),
    .top(),
    .bottom(),
    .firstBaseline(),
    .lastBaseline()
)

// Align to all edges
container.makeConstraints(
    .alignEdges(),
    .alignEdges(to: view.safeAreaLayoutGuide),
    .alignEdges(insets: .init(top: 10, leading: 20, bottom: 10, trailing: 20))
)

// Fixed dimensions
button.makeConstraints(
    .fixedWidth(100),
    .fixedWidth(.greaterThanOrEqual, 100)
)

// Centering
button.makeConstraints(
    .center(),
    .center(in: container)
)

// Relative dimensions
button.makeConstraints(
    .relativeHeight(),
    .relativeHeight(to: otherButton),
    .relativeHeight(to: otherButton, multiplier: 0.5),
    .relativeHeight(.lessThanOrEqual, to: otherButton),
    .relativeHeight(.equal, to: otherButton, attribute: .width, multiplier: 0.5, constant: 10)
)

// Setting size
button.makeConstraints(
    .size(.greaterThanOrEqual, CGSize(width: 100, height: 100)),
    .size(CGSize(width: 100, height: 100))
)

// Matching size
button.makeConstraints(
    .relativeSize(),
    .relativeSize(to: otherButton),
    .relativeSize(to: otherButton, multiplier: 0.5),
    .relativeSize(.lessThanOrEqual, to: otherButton)
)

// Adding custom debug identifiers
button.makeConstraints(
    .leading() <- "yay"
)

// Auto debug identifiers
ConstraintGroup.debugConstraints = true
let constraints = button.makeConstraints(
    .leading()
)

constraints.first?.identifier

// Using priority to give a button a nice chunky width, but not go outside the
// edges of the screen on narrower devices.
button.makeConstraints(
    .fixedWidth(320) ~ .defaultHigh,
    .leading(.greaterThanOrEqual, to: view.readableContentGuide),
    .trailing(.lessThanOrEqual, to: view.readableContentGuide)
)

// Easily write extensions for common cases...
extension ConstraintGroup {

    static func buttonWidth(
        preferred: CGFloat,
        withIn secondItem: ConstrainableItem? = nil,
        file: StaticString = #file,
        line: UInt = #line
        ) -> ConstraintGroup {
        return .init(
            file: file,
            line: line,
            composedOf:
            .fixedWidth(preferred) ~ .defaultHigh,
            .leading(.greaterThanOrEqual, to: secondItem),
            .trailing(.lessThanOrEqual, to: secondItem)
        )
    }
}

// ...and use them as if they were part of the library.
button.makeConstraints(
    .buttonWidth(preferred: 320, withIn: view.readableContentGuide)
)
