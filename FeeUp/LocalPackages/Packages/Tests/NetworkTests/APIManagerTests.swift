import XCTest
import Foundation
import Mocks
@testable import Network

class APIManagerTests: XCTestCase {
    var sut: APIManager!
    var mockNetwork: NetworkingMock!

    override func setUp() {
        super.setUp()
        mockNetwork = .init()
        sut = APIManager(network: mockNetwork)

    }

    override func tearDown() {
        sut = nil
        mockNetwork = nil
        super.tearDown()
    }
    
    func test_perform_SuccessfulRequest() async {
        let url = URL(string: "https://example.com")!
        let testData = "Test data".data(using: .utf8)!
        let mockResponse: URLResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let request = URLRequest(url: url)

        mockNetwork.given(.data(for: .value(request), willReturn: (testData, mockResponse)))

        do {
            let mockRequest = RequestProtocolMock()
            mockRequest.given(.createURLRequest(willReturn: request))
            let result = try await sut.perform(mockRequest)
            XCTAssertEqual(testData, result)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_perform_RequestFailureWithServerResponse() async {
        let url = URL(string: "https://example.com")!
        let testData = "Error data".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
        let request = URLRequest(url: url)
        mockNetwork.given(.data(for: .value(request), willReturn: (testData, mockResponse)))
        do {
            let mockRequest = RequestProtocolMock()
            mockRequest.given(.createURLRequest(willReturn: request))
            _ = try await sut.perform(mockRequest)
            XCTFail("Expected an error, but request succeeded")
        } catch {
            guard case NetworkError.invalidServerResponse(let data) = error else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(data, testData)
        }
    }

    func test_perform_RequestFailureWithNetworkError() async {
        let url = URL(string: "https://example.com")!
        let request = URLRequest(url: url)
        let localError = NSError(domain: "netowrk is not available", code: 404)
        mockNetwork.given(.data(for: .value(request), willThrow: localError))
        do {
            let mockRequest = RequestProtocolMock()
            mockRequest.given(.createURLRequest(willReturn: request))
            _ = try await sut.perform(mockRequest)
            XCTFail("Expected an error, but request succeeded")
        } catch {
            XCTAssertEqual(error.localizedDescription, localError.localizedDescription)
        }
    }
}
