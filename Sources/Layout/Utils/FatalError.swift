@usableFromInline
enum FatalError {
    /// Crash. Runs `fatalError` unless overriden.
    private static var _crash: (@autoclosure () -> String, StaticString, UInt) -> Void = { message, file, line in
        fatalError(message(), file: file, line: line)
    }

    @usableFromInline
    static func crash(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        _crash(message(), file, line)
    }

    #if DEBUG
        static func withTestFatalError(_ f: () -> Void) -> Bool {
            let originalCrash = _crash
            defer { _crash = originalCrash }
            var crashed = false
            _crash = { message, _, _ in
                print("would have crashed with message:", message())
                crashed = true
            }
            f()
            return crashed
        }
    #endif
}
