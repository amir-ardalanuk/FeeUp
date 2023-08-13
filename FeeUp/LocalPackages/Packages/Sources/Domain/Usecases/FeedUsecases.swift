import Foundation

public protocol FeedUsecases {
    func fetchLatest(withSearch: String?, page: Int, pageSize: Int) async throws -> [News]
    func filter(country: String?, category: String?) async throws -> [News]
    func countries() async throws -> [FeedCountries]
}

public protocol FeedBookmarkUsecases {
    func bookmark(news: News) async throws
    func removeBookmark(newsId: String) async throws
}

extension FeedUsecases {
    func fetchLatest(withSearch search: String? = nil, page: Int = 1, pageSize: Int = 100) async throws -> [News] {
        try await fetchLatest(withSearch: search, page: page, pageSize: pageSize)
    }

    func filter(country: String? = nil, category: String? = nil) async throws -> [News] {
        try await filter(country: country, category: category)
    }

}
