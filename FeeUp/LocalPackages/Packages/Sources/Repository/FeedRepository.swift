import Foundation
import Domain
import Persistence
import API

final public class FeedRepository: FeedUsecases, FeedBookmarkUsecases {
    private let feedAPI: FeedAPIProtocol
    private let feedBookmarkPersistence: FeedPersistencing

    public init(feedAPI: FeedAPIProtocol, feedBookmarkPersistence: FeedPersistencing) {
        self.feedAPI = feedAPI
        self.feedBookmarkPersistence = feedBookmarkPersistence
    }

    public func fetchLatest(query: FeedQuery) async throws -> [News] {
        try await feedAPI.fetchLatest(query: query)
    }

    public func countries() async throws -> FeedCountries {
        try await feedAPI.countries()
    }

    public func bookmark(news: News) async throws {
        try feedBookmarkPersistence.saveFeed(news)
    }

    public func removeBookmark(news: News) async throws {
        try feedBookmarkPersistence.removeFeed(withUrl: news.url)
    }

    public func isBookmarked(news: News) throws -> Bool {
        try feedBookmarkPersistence.isBookmarked(newsURL: news.url)
    }

    public func categories() async throws -> Domain.FeedCategories {
        try await feedAPI.categories()
    }
}

