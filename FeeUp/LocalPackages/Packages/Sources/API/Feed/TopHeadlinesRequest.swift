import Foundation

public struct TopHeadlines {
    public let query: String?
    public let category: FeedCategory?
    public let country: FeedCountry?
    public let pageSize: Int = 100
    public let page: Int = 1

    public init(query: String? = nil, category: FeedCategory? = nil, country: FeedCountry? = nil) {
        self.query = query
        self.category = category
        self.country = country
    }
}
