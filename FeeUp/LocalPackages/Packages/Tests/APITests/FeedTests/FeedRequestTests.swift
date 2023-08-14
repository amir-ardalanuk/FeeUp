import XCTest
import Foundation
import Domain
import Network
@testable import API

class FeedRequestTests: XCTestCase {
    var sut: FeedRequest!

    func test_topHeadlines_withEmptyQuery() throws {
        let query: FeedQuery = .init()
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let json = try JSONSerialization.jsonObject(with: request.httpBody!) as! [String: Any]
        XCTAssertEqual(json["page"] as! Int, 1)
        XCTAssertEqual(json["pageSize"] as! Int, 100)
        XCTAssertNil(json["q"])
        XCTAssertNil(json["category"])
        XCTAssertNil(json["country"])
    }

    func test_topHeadlines_withCountryQuery() throws {
        let query: FeedQuery = .init(country: FeedCountry(key: "en", name: "English", flag: "none"))
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let json = try JSONSerialization.jsonObject(with: request.httpBody!) as! [String: Any]
        XCTAssertEqual(json["page"] as! Int, 1)
        XCTAssertEqual(json["pageSize"] as! Int, 100)
        XCTAssertEqual(query.country?.key, (json["country"] as! String))
        XCTAssertNil(json["q"])
        XCTAssertNil(json["category"])
    }

    func test_topHeadlines_withCategoryQuery() throws {
        let query: FeedQuery = .init(category: FeedCategory.business)
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let json = try JSONSerialization.jsonObject(with: request.httpBody!) as! [String: Any]
        XCTAssertEqual(json["page"] as! Int, 1)
        XCTAssertEqual(json["pageSize"] as! Int, 100)
        XCTAssertEqual(json["category"] as! String, query.category!.rawValue)
        XCTAssertNil(json["country"])
        XCTAssertNil(json["q"])
    }


    func test_topHeadlines_withSearchQuery() throws {
        let query: FeedQuery = .init(query: "home")
        sut = .topHeadlines(query)
        let request = try sut.createURLRequest()
        let json = try JSONSerialization.jsonObject(with: request.httpBody!) as! [String: Any]
        XCTAssertEqual(json["page"] as! Int, 1)
        XCTAssertEqual(json["pageSize"] as! Int, 100)
        XCTAssertNil(json["category"])
        XCTAssertNil(json["country"])
        XCTAssertEqual(json["q"] as! String, query.query!)
    }
}
