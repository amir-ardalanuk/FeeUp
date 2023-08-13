import Foundation
import Network
import Domain

final class FeedAPIUsecases: FeedUsecases {
    private let requestManager: RequestManagerProtocol
    private let resourceLoader: ResourceLoading

    public init(requestManager: RequestManagerProtocol, resourceLoader: ResourceLoading) {
        self.requestManager = requestManager
        self.resourceLoader = resourceLoader
    }

    func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News] {
        let response: ServerResponse<[News]> = try await requestManager.perform(FeedRequest.topHeadlines(query))
        return response.articles

    }

    func countries() async throws -> Domain.FeedCountries {
        guard let jsonData = try resourceLoader.data(forResource: "countries", withExtension: "json") else {
            #if DEBUG
            fatalError("Can't find the file")
            #else
            return []
            #endif
        }
        return try requestManager.decoder.decode(jsonData, type: FeedCountries.self)
    }

}
