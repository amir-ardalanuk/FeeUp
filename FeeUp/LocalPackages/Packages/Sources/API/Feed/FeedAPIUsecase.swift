import Foundation
import Network
import Domain

//sourcery: AutoMockable
public protocol FeedAPIProtocol {
    func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News]
    func countries() async throws -> Domain.FeedCountries
}

public final class FeedAPIUsecases: FeedAPIProtocol {
    enum Constant {
        static let countryJsonFileName = "countries"
        static let countryJsonFileExt = "json"
    }
    private let requestManager: RequestManagerProtocol
    private let resourceLoader: ResourceLoading

    public init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
        self.resourceLoader = Bundle.module
    }

    init(requestManager: RequestManagerProtocol, resourceLoader: ResourceLoading) {
        self.requestManager = requestManager
        self.resourceLoader = resourceLoader
    }

    public func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News] {
        let response: ServerResponse<[News]> = try await requestManager.perform(FeedRequest.topHeadlines(query))
        return response.articles
    }

    public func countries() async throws -> Domain.FeedCountries {
        guard let jsonData = try resourceLoader.data(forResource: Constant.countryJsonFileName, withExtension: Constant.countryJsonFileExt) else {
            #if DEBUG
            fatalError("Can't find the file")
            #else
            return []
            #endif
        }
        return try requestManager.decoder.decode(jsonData, type: FeedCountries.self)
    }

}
