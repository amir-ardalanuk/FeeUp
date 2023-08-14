import Foundation
import Domain

public protocol FeedPersistencing {
    func saveFeed(_ model: News) throws
    func removeFeed(withUrl url: String) throws
    func fetchAllFeed() throws -> [News]
}

final class UserDefaultsFeedPersistence: FeedPersistencing {
    enum Constant {
        static let newsKey = "NewsList"
    }
    
    public init(userDefault: UserDefaults, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.userDefault = userDefault
        self.encoder = encoder
        self.decoder = decoder
    }

    private let userDefault: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    private func save(all news: [Domain.News]) throws {
        let data = try encoder.encode(news)
        userDefault.set(data, forKey: Constant.newsKey)
    }

    public func saveFeed(_ model: Domain.News) throws {
        var currentFeeds = Set(try fetchAllFeed())
        currentFeeds.insert(model)
        try save(all: Array(currentFeeds))
    }

    public func removeFeed(withUrl url: String) throws {
        var currentFeeds = try fetchAllFeed()
        guard !currentFeeds.isEmpty else { return }
        currentFeeds.removeAll(where: { $0.url == url})
        try save(all: currentFeeds)
    }

    public func fetchAllFeed() throws  -> [Domain.News] {
        guard let newsData = userDefault.data(forKey: Constant.newsKey) else {
             return []
        }
        return try decoder.decode([News].self, from: newsData)
    }
}

