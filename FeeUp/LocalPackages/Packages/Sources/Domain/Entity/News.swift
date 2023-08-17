import Foundation

// MARK: - News

public struct News: Codable, Hashable, Identifiable {
    public let source: Source
    public let author: String?
    public let title, description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: Date
    public let content: String?

    public var id: String { url }

    public init(source: Source, author: String? = nil, title: String, description: String, url: String, urlToImage: String? = nil, publishedAt: Date, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
