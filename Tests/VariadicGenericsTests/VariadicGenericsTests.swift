import XCTest
@testable import VariadicGenerics

final class VariadicGenericsTests: XCTestCase {
    func testResolution() {
        // Given
        let container = DummyContainer()
        container.register(42)
        let resolver: ServiceResolver = container

        // When
        let resolved = resolver.resolve() as Int

        // Then
        XCTAssertEqual(resolved, 42)
    }

    func testInstance() {
        // Given
        struct Dummy: Equatable {
            let value: Int
        }

        let container = DummyContainer()
        container.register(42)
        let resolver: ServiceResolver = container

        // When
        let resolved = resolver.instance(from: Dummy.init)

        // Then
        XCTAssertEqual(resolved, Dummy(value: 42))
    }
}

private final class DummyContainer: ServiceResolver {
    private var instances: [ObjectIdentifier: Any] = [:]

    func register<T>(_ instance: T) {
        instances[ObjectIdentifier(T.self)] = instance
    }

    func resolve<T>() -> T {
        guard let instance = instances[ObjectIdentifier(T.self)] as? T else {
            fatalError("not registered")
        }
        return instance
    }
}
