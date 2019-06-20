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

extension Array where Element == NSLayoutConstraint {
    /// Sets the constant of each element of the receiver to the desired
    /// constant.
    ///
    /// - Parameter constant: The new constant.
    public func setConstant(_ constant: CGFloat) {
        self.forEach {
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

enum FatalError {
    /// Crash. Runs `fatalError` unless overriden.
    private(set) static var crash: (@autoclosure () -> String, StaticString, UInt) -> Void = { message, file, line in
        fatalError(message(), file: file, line: line)
    }

    #if DEBUG
    static func withTestFatalError(_ f: () -> Void) -> Bool {
        var originalCrash = crash
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
