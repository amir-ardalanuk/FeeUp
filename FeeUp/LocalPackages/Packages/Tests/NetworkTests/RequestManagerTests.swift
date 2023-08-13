import XCTest
import SwiftyMocky
import Foundation
@testable import Network

class RequestManagerTests: XCTestCase {
    struct TestResponse: Codable, Hashable {
        let message: String

        static let mock = TestResponse(message: "Test Message")
    }

    var sut: RequestManager!
    var mockApiManager: APIManagerProtocolMock!
    var mockDataDecoder: DataDecoderProtocolMock!

    override func setUp() {
        super.setUp()
        mockApiManager = APIManagerProtocolMock()
        mockDataDecoder = DataDecoderProtocolMock()
        sut = RequestManager(apiManager: mockApiManager, decoder: mockDataDecoder)
        Matcher.default.register(RequestProtocol.self) { lhs, rhs in
            do {
                return try (lhs.createURLRequest() == rhs.createURLRequest())
            } catch {
                return false
            }

        }
    }

    func test_perform_withSuccessResponse() async throws {
        let responseData = try JSONEncoder().encode(TestResponse.mock)
        let request = URLRequest(url: .init(string: "https://example.com")!)
        let mockRequest = RequestProtocolMock()
        mockRequest.given(.createURLRequest(willReturn: request))

        mockApiManager.given(.perform(.value(mockRequest), willReturn: responseData))
        mockDataDecoder.given(.decode(.value(responseData), type: .any, willReturn: TestResponse.mock))

        let response: TestResponse = try await sut.perform(mockRequest)
        XCTAssertEqual(response.message, TestResponse.mock.message)
    }

    func test_perform_withFailedResponseWhenFailedDecodoing() async throws {
        let responseData = try JSONEncoder().encode(TestResponse.mock)
        let request = URLRequest(url: .init(string: "https://example.com")!)
        let mockRequest = RequestProtocolMock()
        mockRequest.given(.createURLRequest(willReturn: request))

        let decodeError = NSError(domain: "Can't parse response", code: 500)
        mockApiManager.given(.perform(.value(mockRequest), willReturn: responseData))
        mockDataDecoder.given(.decode(.value(responseData), type: .any, willProduce: { (stub: StubberThrows<TestResponse>) in
            stub.throw(decodeError)
        }))
        do {
            let _: TestResponse = try await sut.perform(mockRequest)
            XCTFail("Expected an error, but request succeeded")
        } catch {
            XCTAssertEqual(error.localizedDescription, decodeError.localizedDescription)
        }
    }

    func test_perform_withFailedSeverResponse() async throws {
        let serverError = ServerError(success: false, message: "Can't find your request")
        let responseData = try JSONEncoder().encode(serverError)
        let request = URLRequest(url: .init(string: "https://example.com")!)
        let mockRequest = RequestProtocolMock()
        mockDataDecoder.given(.decode(.value(responseData), type: .any, willReturn: serverError))
        mockRequest.given(.createURLRequest(willReturn: request))

        mockApiManager.given(.perform(.value(mockRequest), willThrow: NetworkError.invalidServerResponse(responseData)))
        do {
            let _: TestResponse = try await sut.perform(mockRequest)
            XCTFail("Expected an error, but request succeeded")
        } catch {
            let networkError = error as! NetworkError
            XCTAssertEqual(networkError, .ServerError(serverError))
        }
    }
}
