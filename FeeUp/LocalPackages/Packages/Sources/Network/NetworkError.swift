import Foundation

/// An enumeration representing possible network-related errors.
public enum NetworkError: Error, Equatable, CustomStringConvertible {
    case invalidURL
    case invalidServerResponse(Data?)
    case ServerError(ServerError)
    case failedParsingData

    public var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidServerResponse(let data):
            return "Invalid Server Response with \(String(data: data ?? .init(), encoding: .utf8) ?? "-")"
        case .ServerError(let serverError):
            return serverError.message
        case .failedParsingData:
            return "Failed Parsing Data"
        }
    }
}

/// A structure representing a server error response.
public struct ServerError: Codable, Hashable, Equatable {
    public let success: Bool
    public let message: String
}
