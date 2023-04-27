protocol ServiceResolver {
    func resolve<T>() -> T
}

// before variadic generics...
extension ServiceResolver {
    func instance<T, P0>(from initializer: (P0) -> T) -> T {
        return initializer(resolve())
    }

    func instance<T, P0, P1>(from initializer: (P0, P1) -> T) -> T {
        return initializer(resolve(), resolve())
    }

    func instance<T, P0, P1, P2>(from initializer: (P0, P1, P2) -> T) -> T {
        return initializer(resolve(), resolve(), resolve())
    }

    func instance<T, P0, P1, P2, P3>(from initializer: (P0, P1, P2, P3) -> T) -> T {
        return initializer(resolve(), resolve(), resolve(), resolve())
    }
}

// after variadic generics...
extension ServiceResolver {
    func instance<T, each P>(from initializer: (repeat each P) -> T) -> T {
        initializer(repeat resolve() as each P)
    }
}

