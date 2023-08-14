import XCTest
import Foundation
import Domain
import Network
import Mocks
import SwiftyMocky
@testable import API

class FeedAPIUsecasesTests: XCTestCase {
    var sut: FeedAPIUsecases!
    var resourceLoadingMock: ResourceLoadingMock!
    var requestManagerMock: RequestManagerProtocolMock!

    override func setUp() {
        super.setUp()
        resourceLoadingMock = ResourceLoadingMock()
        requestManagerMock = RequestManagerProtocolMock()
        sut = .init(requestManager: requestManagerMock, resourceLoader: resourceLoadingMock)
        Matcher.default.register(RequestProtocol.self) { lhs, rhs in
            do {
                return try (lhs.createURLRequest() == rhs.createURLRequest())
            } catch {
                return false
            }
        }

    }

    override func tearDown() {
        sut = nil
        resourceLoadingMock = nil
        requestManagerMock = nil
        super.tearDown()
    }
}

// MARK: - Test fetchLatest method
extension FeedAPIUsecasesTests {
    func test_fetchLatest_whenNetworkRetriveDataSuccessfuly() async throws {
        let query: FeedQuery = .init()
        let request = FeedRequest.topHeadlines(query)
        let news = News.stub()
        let serverResponse = ServerResponse(status: "success", totalResults: 1, articles: [news])
        requestManagerMock.given(.perform(.value(request), willReturn: serverResponse))
        let result = try await sut.fetchLatest(query: query)
        XCTAssertEqual(result, [news])
    }

    func test_fetchLatest_whenNetworkThrowAnError() async throws {
        let query: FeedQuery = .init()
        let request = FeedRequest.topHeadlines(query)
        let serverError = ServerError(success: false, message: "try again later")
        let networkError = NetworkError.serverError(serverError)
        requestManagerMock.given(.perform(.value(request), willThrow: networkError))
        do {
            _ = try await sut.fetchLatest(query: query)
            XCTFail("should not pass if network throw an error")
        } catch {
            XCTAssertEqual(networkError, error as! NetworkError)
        }
    }
}

// MARK: - Test countries method
extension FeedAPIUsecasesTests {
    private func provideCountryData() -> Data {
        let countryData = """
        [{"key": "ae",
        "name": "United Arab Emirates",
        "flag": "🇦🇪"
        }]
        """
        return countryData.data(using: .utf8)!
    }

    func test_countries_whenDataLoadSuccessfully() async throws {
        let stubData = provideCountryData()
        resourceLoadingMock.given(.data(forResource: .value(FeedAPIUsecases.Constant.countryJsonFileName), withExtension: .value(FeedAPIUsecases.Constant.countryJsonFileExt), willReturn: stubData))
        requestManagerMock.given(.decoder(getter: JsonDecoder()))
        let result = try await sut.countries()
        XCTAssertEqual(result.first?.key, "ae")
        XCTAssertEqual(result.first?.name, "United Arab Emirates")
        XCTAssertEqual(result.first?.flag, "🇦🇪")
    }

    func test_countries_whenLoaderCantFindAFile() async throws {
        let localError = NSError(domain: "can't find a file", code: 404)
        resourceLoadingMock.given(.data(forResource: .value(FeedAPIUsecases.Constant.countryJsonFileName), withExtension: .value(FeedAPIUsecases.Constant.countryJsonFileExt), willThrow: localError))
        do {
            _ = try await sut.countries()
            XCTFail("should not pass if network throw an error")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }
}
