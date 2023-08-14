import Foundation
import Domain

public extension News {
    static func stub(
        source: Source = .stub(),
        author: String? = nil,
        title: String = "title",
        description: String = "description",
        url: String = "https://example.com",
        urlToImage: String? = nil,
        publishedAt: Date = .now,
        content: String = "content"
    ) -> Self {
        News(
            source: source,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content
        )
    }
}
