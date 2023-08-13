// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
@testable import Network


// MARK: - APIManagerProtocol

open class APIManagerProtocolMock: APIManagerProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func perform(_ request: RequestProtocol) throws -> Data {
        addInvocation(.m_perform__request(Parameter<RequestProtocol>.value(`request`)))
		let perform = methodPerformValue(.m_perform__request(Parameter<RequestProtocol>.value(`request`))) as? (RequestProtocol) -> Void
		perform?(`request`)
		var __value: Data
		do {
		    __value = try methodReturnValue(.m_perform__request(Parameter<RequestProtocol>.value(`request`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for perform(_ request: RequestProtocol). Use given")
			Failure("Stub return value not specified for perform(_ request: RequestProtocol). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_perform__request(Parameter<RequestProtocol>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_perform__request(let lhsRequest), .m_perform__request(let rhsRequest)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "_ request"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_perform__request(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_perform__request: return ".perform(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func perform(_ request: Parameter<RequestProtocol>, willReturn: Data...) -> MethodStub {
            return Given(method: .m_perform__request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func perform(_ request: Parameter<RequestProtocol>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_perform__request(`request`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func perform(_ request: Parameter<RequestProtocol>, willProduce: (StubberThrows<Data>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_perform__request(`request`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Data).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func perform(_ request: Parameter<RequestProtocol>) -> Verify { return Verify(method: .m_perform__request(`request`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func perform(_ request: Parameter<RequestProtocol>, perform: @escaping (RequestProtocol) -> Void) -> Perform {
            return Perform(method: .m_perform__request(`request`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - Networking

open class NetworkingMock: Networking, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func data(for url: URLRequest) throws -> (Data, URLResponse) {
        addInvocation(.m_data__for_url(Parameter<URLRequest>.value(`url`)))
		let perform = methodPerformValue(.m_data__for_url(Parameter<URLRequest>.value(`url`))) as? (URLRequest) -> Void
		perform?(`url`)
		var __value: (Data, URLResponse)
		do {
		    __value = try methodReturnValue(.m_data__for_url(Parameter<URLRequest>.value(`url`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for data(for url: URLRequest). Use given")
			Failure("Stub return value not specified for data(for url: URLRequest). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_data__for_url(Parameter<URLRequest>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_data__for_url(let lhsUrl), .m_data__for_url(let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "for url"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_data__for_url(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_data__for_url: return ".data(for:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func data(for url: Parameter<URLRequest>, willReturn: (Data, URLResponse)...) -> MethodStub {
            return Given(method: .m_data__for_url(`url`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func data(for url: Parameter<URLRequest>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_data__for_url(`url`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func data(for url: Parameter<URLRequest>, willProduce: (StubberThrows<(Data, URLResponse)>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_data__for_url(`url`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: ((Data, URLResponse)).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func data(for url: Parameter<URLRequest>) -> Verify { return Verify(method: .m_data__for_url(`url`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func data(for url: Parameter<URLRequest>, perform: @escaping (URLRequest) -> Void) -> Perform {
            return Perform(method: .m_data__for_url(`url`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - RequestManagerProtocol

open class RequestManagerProtocolMock: RequestManagerProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    @discardableResult
	open func perform<T: Decodable>(_ request: RequestProtocol) throws -> T {
        addInvocation(.m_perform__request(Parameter<RequestProtocol>.value(`request`)))
		let perform = methodPerformValue(.m_perform__request(Parameter<RequestProtocol>.value(`request`))) as? (RequestProtocol) -> Void
		perform?(`request`)
		var __value: T
		do {
		    __value = try methodReturnValue(.m_perform__request(Parameter<RequestProtocol>.value(`request`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for perform<T: Decodable>(_ request: RequestProtocol). Use given")
			Failure("Stub return value not specified for perform<T: Decodable>(_ request: RequestProtocol). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_perform__request(Parameter<RequestProtocol>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_perform__request(let lhsRequest), .m_perform__request(let rhsRequest)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "_ request"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_perform__request(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_perform__request: return ".perform(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        @discardableResult
		public static func perform<T: Decodable>(_ request: Parameter<RequestProtocol>, willReturn: T...) -> MethodStub {
            return Given(method: .m_perform__request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @discardableResult
		public static func perform(_ request: Parameter<RequestProtocol>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_perform__request(`request`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        @discardableResult
		public static func perform<T: Decodable>(_ request: Parameter<RequestProtocol>, willProduce: (StubberThrows<T>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_perform__request(`request`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (T).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        @discardableResult
		public static func perform(_ request: Parameter<RequestProtocol>) -> Verify { return Verify(method: .m_perform__request(`request`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @discardableResult
		public static func perform(_ request: Parameter<RequestProtocol>, perform: @escaping (RequestProtocol) -> Void) -> Perform {
            return Perform(method: .m_perform__request(`request`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - RequestProtocol

open class RequestProtocolMock: RequestProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var host: String {
		get {	invocations.append(.p_host_get); return __p_host ?? givenGetterValue(.p_host_get, "RequestProtocolMock - stub value for host was not defined") }
	}
	private var __p_host: (String)?

    public var path: String {
		get {	invocations.append(.p_path_get); return __p_path ?? givenGetterValue(.p_path_get, "RequestProtocolMock - stub value for path was not defined") }
	}
	private var __p_path: (String)?

    public var headers: [String: String] {
		get {	invocations.append(.p_headers_get); return __p_headers ?? givenGetterValue(.p_headers_get, "RequestProtocolMock - stub value for headers was not defined") }
	}
	private var __p_headers: ([String: String])?

    public var params: [String: Any] {
		get {	invocations.append(.p_params_get); return __p_params ?? givenGetterValue(.p_params_get, "RequestProtocolMock - stub value for params was not defined") }
	}
	private var __p_params: ([String: Any])?

    public var urlParams: [String: String?] {
		get {	invocations.append(.p_urlParams_get); return __p_urlParams ?? givenGetterValue(.p_urlParams_get, "RequestProtocolMock - stub value for urlParams was not defined") }
	}
	private var __p_urlParams: ([String: String?])?

    public var requestType: RequestType {
		get {	invocations.append(.p_requestType_get); return __p_requestType ?? givenGetterValue(.p_requestType_get, "RequestProtocolMock - stub value for requestType was not defined") }
	}
	private var __p_requestType: (RequestType)?





    open func createURLRequest() throws -> URLRequest {
        addInvocation(.m_createURLRequest)
		let perform = methodPerformValue(.m_createURLRequest) as? () -> Void
		perform?()
		var __value: URLRequest
		do {
		    __value = try methodReturnValue(.m_createURLRequest).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createURLRequest(). Use given")
			Failure("Stub return value not specified for createURLRequest(). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createURLRequest
        case p_host_get
        case p_path_get
        case p_headers_get
        case p_params_get
        case p_urlParams_get
        case p_requestType_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createURLRequest, .m_createURLRequest): return .match
            case (.p_host_get,.p_host_get): return Matcher.ComparisonResult.match
            case (.p_path_get,.p_path_get): return Matcher.ComparisonResult.match
            case (.p_headers_get,.p_headers_get): return Matcher.ComparisonResult.match
            case (.p_params_get,.p_params_get): return Matcher.ComparisonResult.match
            case (.p_urlParams_get,.p_urlParams_get): return Matcher.ComparisonResult.match
            case (.p_requestType_get,.p_requestType_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_createURLRequest: return 0
            case .p_host_get: return 0
            case .p_path_get: return 0
            case .p_headers_get: return 0
            case .p_params_get: return 0
            case .p_urlParams_get: return 0
            case .p_requestType_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createURLRequest: return ".createURLRequest()"
            case .p_host_get: return "[get] .host"
            case .p_path_get: return "[get] .path"
            case .p_headers_get: return "[get] .headers"
            case .p_params_get: return "[get] .params"
            case .p_urlParams_get: return "[get] .urlParams"
            case .p_requestType_get: return "[get] .requestType"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func host(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_host_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func path(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_path_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func headers(getter defaultValue: [String: String]...) -> PropertyStub {
            return Given(method: .p_headers_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func params(getter defaultValue: [String: Any]...) -> PropertyStub {
            return Given(method: .p_params_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func urlParams(getter defaultValue: [String: String?]...) -> PropertyStub {
            return Given(method: .p_urlParams_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func requestType(getter defaultValue: RequestType...) -> PropertyStub {
            return Given(method: .p_requestType_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func createURLRequest(willReturn: URLRequest...) -> MethodStub {
            return Given(method: .m_createURLRequest, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createURLRequest(willThrow: Error...) -> MethodStub {
            return Given(method: .m_createURLRequest, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createURLRequest(willProduce: (StubberThrows<URLRequest>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createURLRequest, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (URLRequest).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createURLRequest() -> Verify { return Verify(method: .m_createURLRequest)}
        public static var host: Verify { return Verify(method: .p_host_get) }
        public static var path: Verify { return Verify(method: .p_path_get) }
        public static var headers: Verify { return Verify(method: .p_headers_get) }
        public static var params: Verify { return Verify(method: .p_params_get) }
        public static var urlParams: Verify { return Verify(method: .p_urlParams_get) }
        public static var requestType: Verify { return Verify(method: .p_requestType_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createURLRequest(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_createURLRequest, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

