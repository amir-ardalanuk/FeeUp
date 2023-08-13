import Foundation

public protocol FeedUsecases {
    func fetchLatest(query: FeedQuery) async throws -> [News]
    func countries() async throws -> FeedCountries
}

public protocol FeedBookmarkUsecases {
    func bookmark(news: News) async throws
    func removeBookmark(newsId: String) async throws
}
