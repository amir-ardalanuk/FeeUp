import XCTest
import Foundation
import Domain
import API
import Persistence
import Mocks
import SwiftyMocky
@testable import Repository

class FeedRepositoryTests: XCTestCase {
    var sut: FeedRepository!
    var feedBookmarkPersistence: FeedPersistencingMock!
    var feedAPIMock: FeedAPIProtocolMock!

    enum Constant {
        static let country: FeedCountry = .init(key: "us", name: "USA", flag: "")
    }

    override func setUp() {
        super.setUp()
        feedBookmarkPersistence = FeedPersistencingMock()
        feedAPIMock = FeedAPIProtocolMock()
        sut = .init(feedAPI: feedAPIMock, feedBookmarkPersistence: feedBookmarkPersistence)
    }

    override func tearDown() {
        sut = nil
        feedBookmarkPersistence = nil
        feedAPIMock = nil
        super.tearDown()
    }
}

// MARK: - FeedUsecases method tests
extension FeedRepositoryTests {
    func test_fetchLatest_whenFeedAPIReturnDataSuccessfully() async throws {
        let query = FeedQuery(country: Constant.country)
        let news = News.stub()
        feedAPIMock.given(.fetchLatest(query: .value(query), willReturn: [news]))
        let result = try await sut.fetchLatest(query: query)
        XCTAssertEqual(result, [news])
    }

    func test_fetchLatest_whenFeedAPIThrowAnError() async throws {
        let query = FeedQuery(country: Constant.country)
        let localError = NSError(domain: "Server error", code: 500)
        feedAPIMock.given(.fetchLatest(query: .value(query), willThrow: localError))
        do {
            _ = try await sut.fetchLatest(query: query)
            XCTFail("Should not be here")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }

    func test_countries_whenFeedAPIReturnDataSuccessfully() async throws {
        let mockCountry = FeedCountry(key: "ea", name: "test", flag: "test")
        feedAPIMock.given(.countries(willReturn: [mockCountry]))
        let result = try await sut.countries()
        XCTAssertEqual(result, [mockCountry])
    }

    func test_countries_whenFeedAPIThrowAnError() async throws {
        let localError = NSError(domain: "Server error", code: 500)
        feedAPIMock.given(.countries(willThrow: localError))
        do {
            let _ = try await sut.countries()
            XCTFail("Should not be here")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }
}

// MARK: - FeedBookmarkUsecases tests
extension FeedRepositoryTests {
    func test_bookmark_whenDataSavedWihtoutAnyError() async throws {
        let news = News.stub()
        do {
            try await sut.bookmark(news: news)
        } catch {
            XCTFail("Should not be here")
        }
    }

    func test_bookmark_whenThrowAnErrorWhenSaving() async throws {
        let news = News.stub()
        let localError = NSError(domain: "Server error", code: 500)
        feedBookmarkPersistence.given(.saveFeed(.value(news), willThrow: localError))
        do {
            try await sut.bookmark(news: news)
            XCTFail("Should not be here")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }

    func test_removeBookmark_whenDataRemovedSuccessfully() async throws {
        let news = News.stub()
        do {
            try await sut.removeBookmark(news: news)
        } catch {
            XCTFail("Should not be here")
        }
    }

    func test_removeBookmark_whenThrowAnError() async throws {
        let news = News.stub()
        let localError = NSError(domain: "Server error", code: 500)
        feedBookmarkPersistence.given(.removeFeed(withUrl: .value(news.url), willThrow: localError))
        do {
            try await sut.removeBookmark(news: news)
            XCTFail("Should not be here")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }

    func test_isBookmarked_whenDataIsBookmarked() throws {
        let news = News.stub()
        feedBookmarkPersistence.given(.isBookmarked(newsURL: .value(news.url), willReturn: true))
        do {
            let result = try sut.isBookmarked(news: news)
            XCTAssertTrue(result)
        } catch {
            XCTFail("Should not be here")
        }
    }

    func test_isBookmarked_whenDataIsNotBookmarked() throws {
        let news = News.stub()
        feedBookmarkPersistence.given(.isBookmarked(newsURL: .value(news.url), willReturn: false))
        do {
            let result = try sut.isBookmarked(news: news)
            XCTAssertFalse(result)
        } catch {
            XCTFail("Should not be here")
        }
    }

    func test_isBookmarked_whenThrowAnError() async throws {
        let news = News.stub()
        let localError = NSError(domain: "Server error", code: 500)
        feedBookmarkPersistence.given(.isBookmarked(newsURL: .value(news.url), willThrow: localError))
        do {
            let _ = try sut.isBookmarked(news: news)
            XCTFail("Should not be here")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }
}


