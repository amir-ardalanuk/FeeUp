import Foundation

public struct FeedQuery: Equatable {
    public var query: String?
    public var category: FeedCategory?
    public var country: FeedCountry
    public var pageSize: Int = 30
    public var page: Int = 1

    public init(country: FeedCountry, query: String? = nil, category: FeedCategory? = nil) {
        self.query = query
        self.category = category
        self.country = country
    }
}
