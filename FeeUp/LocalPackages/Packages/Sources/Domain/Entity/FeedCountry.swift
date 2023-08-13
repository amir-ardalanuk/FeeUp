import Foundation

// MARK: - Country
public struct FeedCountry: Codable {
    public let key, name, flag: String
}

public typealias FeedCountries = [FeedCountry]
