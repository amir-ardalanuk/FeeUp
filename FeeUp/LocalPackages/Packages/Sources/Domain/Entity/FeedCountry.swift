import Foundation

// MARK: - Country
public struct FeedCountry: Codable, Equatable, Hashable, Identifiable {
    public var id: String { key }
    public let key, name, flag: String

    public init(key: String, name: String, flag: String) {
        self.key = key
        self.name = name
        self.flag = flag
    }
}

public typealias FeedCountries = [FeedCountry]
