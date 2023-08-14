import XCTest
import Foundation
import Domain
import Mocks
@testable import Persistence

final class UserDefaultsFeedPersistenceTests: XCTestCase {
    var sut: UserDefaultsFeedPersistence!
    var userDefault: UserDefaults!
    override func setUp() {
        super.setUp()
        userDefault = .init(suiteName: UUID().uuidString)
        sut = .init(userDefault: userDefault, encoder: .init(), decoder: .init())
    }

    override func tearDown() {
        sut = nil
        userDefault = nil
        super.tearDown()
    }
}

// MARK: fetchAllFeed tests
extension UserDefaultsFeedPersistenceTests {

    func test_fetchAllFeed_whenThereIsNotDataInThere() throws {
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [])
    }

    func test_fetchAllFeed_whenThereSomeDataInThere() throws {
        let news: News = .stub()
        try sut.saveFeed(news)
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [news])
    }

    func test_fetchAllFeed_whenDecoderThrowAnError() throws {
        let mockDecoder = MockJsonDecoder()
        sut = .init(userDefault: userDefault, encoder: .init(), decoder: mockDecoder)
        let localError = NSError(domain: "Can not parse data", code: 400)
        mockDecoder.decodeHandler = {
            throw localError
        }
        let news: News = .stub()
        try sut.saveFeed(news)
        do {
            _ = try sut.fetchAllFeed()
            XCTFail("must be failed this test")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }
}

// MARK: saveFeed tests
extension UserDefaultsFeedPersistenceTests {

    func test_saveFeed_successfullyAddData() throws {
        let news: News = .stub()
        try sut.saveFeed(news)
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [news])
    }

    func test_saveFeed_whenAddAMediaTwice() throws {
        let news: News = .stub()
        try sut.saveFeed(news)
        try sut.saveFeed(news)
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [news])
        XCTAssertEqual(feeds.count, 1)
    }
}


// MARK: removeFeed tests
extension UserDefaultsFeedPersistenceTests {

    func test_removeFeed_successfullyDataRemoved() throws {
        let news: News = .stub()
        try sut.saveFeed(news)
        try sut.removeFeed(withUrl: news.url)
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [])
    }

    func test_removeFeed_whenDataIsNotAvailableInPersistence() throws {
        let news: News = .stub()
        try sut.removeFeed(withUrl: news.url)
        let feeds = try sut.fetchAllFeed()
        XCTAssertEqual(feeds, [])
    }
}
