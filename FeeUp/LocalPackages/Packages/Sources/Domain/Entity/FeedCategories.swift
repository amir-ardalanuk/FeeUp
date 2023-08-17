import Foundation

public struct FeedCategory: Codable, Equatable, Identifiable {
    public init(key: String, name: String, emoji: String) {
        self.key = key
        self.name = name
        self.emoji = emoji
    }

    public var id: String { key }
    public let key: String
    public let name: String
    public let emoji: String
}

public typealias FeedCategories = [FeedCategory]
