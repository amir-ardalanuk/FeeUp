import Foundation

//sourcery: AutoMockable
/// A protocol defining the contract for an API manager.
protocol APIManagerProtocol {
    /// Performs the specified request and returns the response data.
    /// - Parameters:
    ///   - request: The request to perform.
    /// - Returns: The response data.
    /// - Throws: An error if the request fails or the server response is invalid.
    func perform(_ request: RequestProtocol) async throws -> Data
}

/// An API manager implementation for performing network requests.
final class APIManager: APIManagerProtocol {
    private let network: Networking

    /// Initializes a new instance of the API manager with an optional custom URLSession.
    /// - Parameter urlSession: The URLSession to use. If not provided, a shared URLSession is used.
    init(network: Networking = URLSession.shared) {
        self.network = network
    }

    func perform(_ request: RequestProtocol) async throws -> Data {
        let requestURL = try request.createURLRequest()
        let (data, response) = try await network.data(for: requestURL)

        guard let httpResponse = response as? HTTPURLResponse,
              200 ... 299 ~= httpResponse.statusCode
        else {
            throw NetworkError.invalidServerResponse(data)
        }

        return data
    }
}
