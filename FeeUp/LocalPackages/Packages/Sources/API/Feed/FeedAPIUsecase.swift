import Foundation
import Network
import Domain

//sourcery: AutoMockable
public protocol FeedAPIProtocol {
    func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News]
    func countries() async throws -> Domain.FeedCountries
    func categories() async throws -> Domain.FeedCategories
}

public final class FeedAPIUsecases: FeedAPIProtocol {
    enum Constant {
        static let countryJsonFileName = "countries"
        static let countryJsonFileExt = "json"

        static let categoryJsonFileName = "categories"
        static let categoryJsonFileExt = "json"
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
        return response.articles ?? []
    }

    public func countries() async throws -> Domain.FeedCountries {
        guard let jsonData = try resourceLoader.data(forResource: Constant.countryJsonFileName, withExtension: Constant.countryJsonFileExt) else {
            throw ResourceLoadingError.thereIsNotSuchFile
        }
        return try requestManager.decoder.decode(jsonData, type: FeedCountries.self)
    }

    public func categories() async throws -> Domain.FeedCategories {
        guard let jsonData = try resourceLoader.data(forResource: Constant.categoryJsonFileName, withExtension: Constant.categoryJsonFileExt) else {
            throw ResourceLoadingError.thereIsNotSuchFile
        }
        return try requestManager.decoder.decode(jsonData, type: FeedCategories.self)
    }

}
