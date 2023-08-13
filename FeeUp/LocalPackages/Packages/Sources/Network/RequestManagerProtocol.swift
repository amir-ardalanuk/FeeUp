import Foundation

//sourcery: AutoMockable
/// A protocol defining the contract for a request manager.
public protocol RequestManagerProtocol {
    var decoder: DataDecoderProtocol { get }
    /// Performs the specified request and returns the decoded response object.
    /// - Parameter request: The request to perform.
    /// - Returns: The decoded response object.
    /// - Throws: An error if the request fails or the response cannot be decoded.
    ///
    ///
    @discardableResult
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

/// A request manager implementation for performing network requests and decoding the response.
public final class RequestManager: RequestManagerProtocol {
    private let apiManager: APIManagerProtocol
    public let decoder: DataDecoderProtocol
    /// Initializes a new instance of the request manager with an optional custom API manager.
    /// - Parameter apiManager: The API manager to use. If not provided, a default API manager is used.
    init(apiManager: APIManagerProtocol = APIManager(), decoder: DataDecoderProtocol = JsonDecoder()) {
        self.apiManager = apiManager
        self.decoder = decoder
    }

    @discardableResult
    public func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        do {
            let data = try await apiManager.perform(request)
            return try decoder.decode(data, type: T.self)
        } catch {
            if let network = error as? NetworkError {
                switch network {
                case let .invalidServerResponse(data):
                    let serverError = try decoder.decode(data ?? .init(), type: ServerError.self)
                    throw NetworkError.ServerError(serverError)
                default:
                    throw error
                }
            } else {
                throw error
            }
        }
    }
}
