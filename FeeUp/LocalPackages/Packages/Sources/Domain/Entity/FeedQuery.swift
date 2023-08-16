import Foundation

public struct FeedQuery: Equatable {
    public let query: String?
    public let category: FeedCategory?
    public let country: FeedCountry
    public let pageSize: Int = 30
    public let page: Int = 1

    public init(country: FeedCountry, query: String? = nil, category: FeedCategory? = nil) {
        self.query = query
        self.category = category
        self.country = country
    }
}
