import XCTest
import Foundation
import Domain
import Network
@testable import API

class FeedRequestTests: XCTestCase {
    var sut: FeedRequest!

    enum Constant {
        static let country: FeedCountry = .init(key: "us", name: "USA", flag: "")
    }

    func test_topHeadlines_withEmptyQuery() throws {
        let query: FeedQuery = .init(country: Constant.country)
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let queryParam = request.url?.queryParameters!
        XCTAssertEqual(queryParam?["page"], "1")
        XCTAssertEqual(queryParam?["pageSize"], "30")
        XCTAssertEqual(query.country.key, queryParam?["country"])
        XCTAssertNil(queryParam?["category"])
        XCTAssertNil(queryParam?["q"])
    }

    func test_topHeadlines_withCategoryQuery() throws {
        let category = FeedCategory(key: "test", name: "test", emoji: "test")
        let query: FeedQuery = .init(country: Constant.country, category: category)
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let queryParam = request.url?.queryParameters!
        XCTAssertEqual(queryParam?["page"], "1")
        XCTAssertEqual(queryParam?["pageSize"], "30")
        XCTAssertEqual(queryParam?["category"], category.key)
        XCTAssertEqual(query.country.key, queryParam?["country"])
        XCTAssertNil(queryParam?["q"])
    }


    func test_topHeadlines_withSearchQuery() throws {
        let query: FeedQuery = .init(country: Constant.country, query: "home")
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let queryParam = request.url?.queryParameters!
        XCTAssertEqual(queryParam?["page"], "1")
        XCTAssertEqual(queryParam?["pageSize"], "30")
        XCTAssertNil(queryParam?["category"])
        XCTAssertEqual(query.country.key, queryParam?["country"])
        XCTAssertEqual(queryParam?["q"], query.query!)
    }
}

fileprivate extension URL {
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
