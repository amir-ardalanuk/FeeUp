import Foundation

// MARK: - Source

public struct Source: Hashable, Codable {
    public let id: String?
    public let name: String?

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
