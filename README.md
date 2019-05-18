# Layout

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An expressive and extensible DSL for creating Auto Layout constraints and defining declarative layouts.

# Creating Constraints

``` swift
// Creating inactive constraints (save and activate/manipulate later)
let constraints = view.makeConstraints(
  .center(),
  .setSize(CGSize(width: 100, height: 100))
)
```

``` swift
// Creating active constraints
view.applyConstraints(
  .center(),
  .setSize(CGSize(width: 100, height: 100))
)
```

## `UIView` and `UILayoutGuide`
`makeConstraints` and `applyConstraints` operate on both `UIView` and `UILayoutGuide`. All constraints that are setup up in relation to other items may also be either `UIView` or `UILayoutGuide`. 

``` swift
button.applyConstraints(
  .center(in: view.safeAreaLayoutGuide), // relating to a `UILayoutGuide`
  .matchSize(of: otherButton) // relating to a `UIView`
)
```

Constraints that are related to another item default to the receiver’s parent view. Therefore, the following two examples are identical:

``` swift
// Preferred
button.applyConstraints(
  .center()
)
```

``` swift
// Not-preferred
button.applyConstraints(
  .center(in: button.superview)
)
```

## Autoresizing Mask
Layout sets `translatesAutoresizingMaskIntoConstraints` to `false` on the receiver of the `makeContstraints` and `applyConstraints` calls.

## Debugging Constraints
Layout has the ability to add debug identifiers to all constraints that include the file, function, and line number of where the constraint was created. If you are having trouble with ambiguous constraints, you can enable these identifiers like this:

``` swift
// Call this in your AppDelegate
ConstraintGroup.debugConstraints = true
```

# Declarative Layout
wip

---

# Installation
## CocoaPods
Layout has not yet been published as a CocoaPod, but you may still use it. 

To integrate Layout into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'Layout', :git => 'git@github.com:/noremac/Layout.git', :tag => '0.0.2'
```

## Carthage
To integrate Layout into your Xcode project using Carthage, specify it in your Cartfile:
``` ogdl
github "noremac/Layout"
```

Run `carthage update` to build the framework and drag the built
`Layout.framework` into your Xcode project.

# License
This code and tool is under the MIT License. See `LICENSE` file in this repository.
