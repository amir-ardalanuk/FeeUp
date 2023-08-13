import Foundation

//sourcery: AutoMockable
public protocol Networking {
    func data(for url: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: Networking {}
