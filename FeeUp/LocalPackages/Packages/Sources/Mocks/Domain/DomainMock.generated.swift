// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
@testable import Domain


// MARK: - FeedBookmarkUsecases

open class FeedBookmarkUsecasesMock: FeedBookmarkUsecases, Mock {
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





    open func bookmark(news: News) throws {
        addInvocation(.m_bookmark__news_news(Parameter<News>.value(`news`)))
		let perform = methodPerformValue(.m_bookmark__news_news(Parameter<News>.value(`news`))) as? (News) -> Void
		perform?(`news`)
		do {
		    _ = try methodReturnValue(.m_bookmark__news_news(Parameter<News>.value(`news`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func removeBookmark(news: News) throws {
        addInvocation(.m_removeBookmark__news_news(Parameter<News>.value(`news`)))
		let perform = methodPerformValue(.m_removeBookmark__news_news(Parameter<News>.value(`news`))) as? (News) -> Void
		perform?(`news`)
		do {
		    _ = try methodReturnValue(.m_removeBookmark__news_news(Parameter<News>.value(`news`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func isBookmarked(news: News) throws -> Bool {
        addInvocation(.m_isBookmarked__news_news(Parameter<News>.value(`news`)))
		let perform = methodPerformValue(.m_isBookmarked__news_news(Parameter<News>.value(`news`))) as? (News) -> Void
		perform?(`news`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_isBookmarked__news_news(Parameter<News>.value(`news`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for isBookmarked(news: News). Use given")
			Failure("Stub return value not specified for isBookmarked(news: News). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_bookmark__news_news(Parameter<News>)
        case m_removeBookmark__news_news(Parameter<News>)
        case m_isBookmarked__news_news(Parameter<News>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_bookmark__news_news(let lhsNews), .m_bookmark__news_news(let rhsNews)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNews, rhs: rhsNews, with: matcher), lhsNews, rhsNews, "news"))
				return Matcher.ComparisonResult(results)

            case (.m_removeBookmark__news_news(let lhsNews), .m_removeBookmark__news_news(let rhsNews)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNews, rhs: rhsNews, with: matcher), lhsNews, rhsNews, "news"))
				return Matcher.ComparisonResult(results)

            case (.m_isBookmarked__news_news(let lhsNews), .m_isBookmarked__news_news(let rhsNews)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsNews, rhs: rhsNews, with: matcher), lhsNews, rhsNews, "news"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_bookmark__news_news(p0): return p0.intValue
            case let .m_removeBookmark__news_news(p0): return p0.intValue
            case let .m_isBookmarked__news_news(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_bookmark__news_news: return ".bookmark(news:)"
            case .m_removeBookmark__news_news: return ".removeBookmark(news:)"
            case .m_isBookmarked__news_news: return ".isBookmarked(news:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func isBookmarked(news: Parameter<News>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_isBookmarked__news_news(`news`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func bookmark(news: Parameter<News>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_bookmark__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func bookmark(news: Parameter<News>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_bookmark__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func removeBookmark(news: Parameter<News>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_removeBookmark__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func removeBookmark(news: Parameter<News>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_removeBookmark__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func isBookmarked(news: Parameter<News>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_isBookmarked__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func isBookmarked(news: Parameter<News>, willProduce: (StubberThrows<Bool>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_isBookmarked__news_news(`news`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func bookmark(news: Parameter<News>) -> Verify { return Verify(method: .m_bookmark__news_news(`news`))}
        public static func removeBookmark(news: Parameter<News>) -> Verify { return Verify(method: .m_removeBookmark__news_news(`news`))}
        public static func isBookmarked(news: Parameter<News>) -> Verify { return Verify(method: .m_isBookmarked__news_news(`news`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func bookmark(news: Parameter<News>, perform: @escaping (News) -> Void) -> Perform {
            return Perform(method: .m_bookmark__news_news(`news`), performs: perform)
        }
        public static func removeBookmark(news: Parameter<News>, perform: @escaping (News) -> Void) -> Perform {
            return Perform(method: .m_removeBookmark__news_news(`news`), performs: perform)
        }
        public static func isBookmarked(news: Parameter<News>, perform: @escaping (News) -> Void) -> Perform {
            return Perform(method: .m_isBookmarked__news_news(`news`), performs: perform)
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

// MARK: - FeedUsecases

open class FeedUsecasesMock: FeedUsecases, Mock {
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





    open func fetchLatest(query: FeedQuery) throws -> [News] {
        addInvocation(.m_fetchLatest__query_query(Parameter<FeedQuery>.value(`query`)))
		let perform = methodPerformValue(.m_fetchLatest__query_query(Parameter<FeedQuery>.value(`query`))) as? (FeedQuery) -> Void
		perform?(`query`)
		var __value: [News]
		do {
		    __value = try methodReturnValue(.m_fetchLatest__query_query(Parameter<FeedQuery>.value(`query`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetchLatest(query: FeedQuery). Use given")
			Failure("Stub return value not specified for fetchLatest(query: FeedQuery). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func countries() throws -> FeedCountries {
        addInvocation(.m_countries)
		let perform = methodPerformValue(.m_countries) as? () -> Void
		perform?()
		var __value: FeedCountries
		do {
		    __value = try methodReturnValue(.m_countries).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for countries(). Use given")
			Failure("Stub return value not specified for countries(). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func categories() throws -> FeedCategories {
        addInvocation(.m_categories)
		let perform = methodPerformValue(.m_categories) as? () -> Void
		perform?()
		var __value: FeedCategories
		do {
		    __value = try methodReturnValue(.m_categories).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for categories(). Use given")
			Failure("Stub return value not specified for categories(). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchLatest__query_query(Parameter<FeedQuery>)
        case m_countries
        case m_categories

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchLatest__query_query(let lhsQuery), .m_fetchLatest__query_query(let rhsQuery)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				return Matcher.ComparisonResult(results)

            case (.m_countries, .m_countries): return .match

            case (.m_categories, .m_categories): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchLatest__query_query(p0): return p0.intValue
            case .m_countries: return 0
            case .m_categories: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchLatest__query_query: return ".fetchLatest(query:)"
            case .m_countries: return ".countries()"
            case .m_categories: return ".categories()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchLatest(query: Parameter<FeedQuery>, willReturn: [News]...) -> MethodStub {
            return Given(method: .m_fetchLatest__query_query(`query`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func countries(willReturn: FeedCountries...) -> MethodStub {
            return Given(method: .m_countries, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func categories(willReturn: FeedCategories...) -> MethodStub {
            return Given(method: .m_categories, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchLatest(query: Parameter<FeedQuery>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetchLatest__query_query(`query`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetchLatest(query: Parameter<FeedQuery>, willProduce: (StubberThrows<[News]>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetchLatest__query_query(`query`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: ([News]).self)
			willProduce(stubber)
			return given
        }
        public static func countries(willThrow: Error...) -> MethodStub {
            return Given(method: .m_countries, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func countries(willProduce: (StubberThrows<FeedCountries>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_countries, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (FeedCountries).self)
			willProduce(stubber)
			return given
        }
        public static func categories(willThrow: Error...) -> MethodStub {
            return Given(method: .m_categories, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func categories(willProduce: (StubberThrows<FeedCategories>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_categories, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (FeedCategories).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchLatest(query: Parameter<FeedQuery>) -> Verify { return Verify(method: .m_fetchLatest__query_query(`query`))}
        public static func countries() -> Verify { return Verify(method: .m_countries)}
        public static func categories() -> Verify { return Verify(method: .m_categories)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchLatest(query: Parameter<FeedQuery>, perform: @escaping (FeedQuery) -> Void) -> Perform {
            return Perform(method: .m_fetchLatest__query_query(`query`), performs: perform)
        }
        public static func countries(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_countries, performs: perform)
        }
        public static func categories(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_categories, performs: perform)
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

