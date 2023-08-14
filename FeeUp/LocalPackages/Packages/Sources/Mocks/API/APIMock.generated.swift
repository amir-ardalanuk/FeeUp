// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
import Network
@testable import API


// MARK: - ResourceLoading

open class ResourceLoadingMock: ResourceLoading, Mock {
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





    open func data(forResource: String?, withExtension: String?) throws -> Data? {
        addInvocation(.m_data__forResource_forResourcewithExtension_withExtension(Parameter<String?>.value(`forResource`), Parameter<String?>.value(`withExtension`)))
		let perform = methodPerformValue(.m_data__forResource_forResourcewithExtension_withExtension(Parameter<String?>.value(`forResource`), Parameter<String?>.value(`withExtension`))) as? (String?, String?) -> Void
		perform?(`forResource`, `withExtension`)
		var __value: Data? = nil
		do {
		    __value = try methodReturnValue(.m_data__forResource_forResourcewithExtension_withExtension(Parameter<String?>.value(`forResource`), Parameter<String?>.value(`withExtension`))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_data__forResource_forResourcewithExtension_withExtension(Parameter<String?>, Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_data__forResource_forResourcewithExtension_withExtension(let lhsForresource, let lhsWithextension), .m_data__forResource_forResourcewithExtension_withExtension(let rhsForresource, let rhsWithextension)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsForresource, rhs: rhsForresource, with: matcher), lhsForresource, rhsForresource, "forResource"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWithextension, rhs: rhsWithextension, with: matcher), lhsWithextension, rhsWithextension, "withExtension"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_data__forResource_forResourcewithExtension_withExtension(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_data__forResource_forResourcewithExtension_withExtension: return ".data(forResource:withExtension:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func data(forResource: Parameter<String?>, withExtension: Parameter<String?>, willReturn: Data?...) -> MethodStub {
            return Given(method: .m_data__forResource_forResourcewithExtension_withExtension(`forResource`, `withExtension`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func data(forResource: Parameter<String?>, withExtension: Parameter<String?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_data__forResource_forResourcewithExtension_withExtension(`forResource`, `withExtension`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func data(forResource: Parameter<String?>, withExtension: Parameter<String?>, willProduce: (StubberThrows<Data?>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_data__forResource_forResourcewithExtension_withExtension(`forResource`, `withExtension`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Data?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func data(forResource: Parameter<String?>, withExtension: Parameter<String?>) -> Verify { return Verify(method: .m_data__forResource_forResourcewithExtension_withExtension(`forResource`, `withExtension`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func data(forResource: Parameter<String?>, withExtension: Parameter<String?>, perform: @escaping (String?, String?) -> Void) -> Perform {
            return Perform(method: .m_data__forResource_forResourcewithExtension_withExtension(`forResource`, `withExtension`), performs: perform)
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

