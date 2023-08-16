// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
import Domain
@testable import Persistence


// MARK: - FeedPersistencing

open class FeedPersistencingMock: FeedPersistencing, Mock {
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





    open func saveFeed(_ model: News) throws {
        addInvocation(.m_saveFeed__model(Parameter<News>.value(`model`)))
		let perform = methodPerformValue(.m_saveFeed__model(Parameter<News>.value(`model`))) as? (News) -> Void
		perform?(`model`)
		do {
		    _ = try methodReturnValue(.m_saveFeed__model(Parameter<News>.value(`model`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func removeFeed(withUrl url: String) throws {
        addInvocation(.m_removeFeed__withUrl_url(Parameter<String>.value(`url`)))
		let perform = methodPerformValue(.m_removeFeed__withUrl_url(Parameter<String>.value(`url`))) as? (String) -> Void
		perform?(`url`)
		do {
		    _ = try methodReturnValue(.m_removeFeed__withUrl_url(Parameter<String>.value(`url`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func fetchAllFeed() throws -> [News] {
        addInvocation(.m_fetchAllFeed)
		let perform = methodPerformValue(.m_fetchAllFeed) as? () -> Void
		perform?()
		var __value: [News]
		do {
		    __value = try methodReturnValue(.m_fetchAllFeed).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetchAllFeed(). Use given")
			Failure("Stub return value not specified for fetchAllFeed(). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func isBookmarked(newsURL: String) throws -> Bool {
        addInvocation(.m_isBookmarked__newsURL_newsURL(Parameter<String>.value(`newsURL`)))
		let perform = methodPerformValue(.m_isBookmarked__newsURL_newsURL(Parameter<String>.value(`newsURL`))) as? (String) -> Void
		perform?(`newsURL`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_isBookmarked__newsURL_newsURL(Parameter<String>.value(`newsURL`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for isBookmarked(newsURL: String). Use given")
			Failure("Stub return value not specified for isBookmarked(newsURL: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_saveFeed__model(Parameter<News>)
        case m_removeFeed__withUrl_url(Parameter<String>)
        case m_fetchAllFeed
        case m_isBookmarked__newsURL_newsURL(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_saveFeed__model(let lhsModel), .m_saveFeed__model(let rhsModel)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsModel, rhs: rhsModel, with: matcher), lhsModel, rhsModel, "_ model"))
				return Matcher.ComparisonResult(results)

            case (.m_removeFeed__withUrl_url(let lhsUrl), .m_removeFeed__withUrl_url(let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "withUrl url"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchAllFeed, .m_fetchAllFeed): return .match

            case (.m_isBookmarked__newsURL_newsURL(let lhsNewsurl), .m_isBookmarked__newsURL_newsURL(let rhsNewsurl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNewsurl, rhs: rhsNewsurl, with: matcher), lhsNewsurl, rhsNewsurl, "newsURL"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_saveFeed__model(p0): return p0.intValue
            case let .m_removeFeed__withUrl_url(p0): return p0.intValue
            case .m_fetchAllFeed: return 0
            case let .m_isBookmarked__newsURL_newsURL(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_saveFeed__model: return ".saveFeed(_:)"
            case .m_removeFeed__withUrl_url: return ".removeFeed(withUrl:)"
            case .m_fetchAllFeed: return ".fetchAllFeed()"
            case .m_isBookmarked__newsURL_newsURL: return ".isBookmarked(newsURL:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchAllFeed(willReturn: [News]...) -> MethodStub {
            return Given(method: .m_fetchAllFeed, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isBookmarked(newsURL: Parameter<String>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_isBookmarked__newsURL_newsURL(`newsURL`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func saveFeed(_ model: Parameter<News>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_saveFeed__model(`model`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func saveFeed(_ model: Parameter<News>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_saveFeed__model(`model`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func removeFeed(withUrl url: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_removeFeed__withUrl_url(`url`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func removeFeed(withUrl url: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_removeFeed__withUrl_url(`url`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func fetchAllFeed(willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetchAllFeed, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetchAllFeed(willProduce: (StubberThrows<[News]>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetchAllFeed, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: ([News]).self)
			willProduce(stubber)
			return given
        }
        public static func isBookmarked(newsURL: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_isBookmarked__newsURL_newsURL(`newsURL`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func isBookmarked(newsURL: Parameter<String>, willProduce: (StubberThrows<Bool>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_isBookmarked__newsURL_newsURL(`newsURL`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func saveFeed(_ model: Parameter<News>) -> Verify { return Verify(method: .m_saveFeed__model(`model`))}
        public static func removeFeed(withUrl url: Parameter<String>) -> Verify { return Verify(method: .m_removeFeed__withUrl_url(`url`))}
        public static func fetchAllFeed() -> Verify { return Verify(method: .m_fetchAllFeed)}
        public static func isBookmarked(newsURL: Parameter<String>) -> Verify { return Verify(method: .m_isBookmarked__newsURL_newsURL(`newsURL`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func saveFeed(_ model: Parameter<News>, perform: @escaping (News) -> Void) -> Perform {
            return Perform(method: .m_saveFeed__model(`model`), performs: perform)
        }
        public static func removeFeed(withUrl url: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_removeFeed__withUrl_url(`url`), performs: perform)
        }
        public static func fetchAllFeed(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_fetchAllFeed, performs: perform)
        }
        public static func isBookmarked(newsURL: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_isBookmarked__newsURL_newsURL(`newsURL`), performs: perform)
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

