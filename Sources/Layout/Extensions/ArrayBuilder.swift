#if swift(<5.4)
    @_functionBuilder
    public enum ArrayBuilder<Element> {
    }
#else
    @resultBuilder
    public enum ArrayBuilder<Element> {
    }
#endif

public extension ArrayBuilder {
    typealias Expression = Element

    typealias Component = [Element]

    static func buildExpression(_ expression: Expression) -> Component {
        [expression]
    }

    static func buildExpression(_ expression: Expression?) -> Component {
        expression.map({ [$0] }) ?? []
    }

    static func buildBlock(_ children: Component...) -> Component {
        children.flatMap({ $0 })
    }

    static func buildExpression(_ expressions: [Expression]) -> Component {
        expressions
    }

    static func buildOptional(_ children: Component?) -> Component {
        children ?? []
    }

    static func buildBlock(_ component: Component) -> Component {
        component
    }

    static func buildEither(first child: Component) -> Component {
        child
    }

    static func buildEither(second child: Component) -> Component {
        child
    }
}
