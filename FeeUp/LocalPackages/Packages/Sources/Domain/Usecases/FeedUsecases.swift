import Foundation

//sourcery: AutoMockable
public protocol FeedUsecases {
    func fetchLatest(query: FeedQuery) async throws -> [News]
    func countries() async throws -> FeedCountries
    func categories() async throws -> FeedCategories
}

//sourcery: AutoMockable
public protocol FeedBookmarkUsecases {
    func bookmark(news: News) async throws
    func removeBookmark(news: News) async throws
    func isBookmarked(news: News) throws -> Bool
}
