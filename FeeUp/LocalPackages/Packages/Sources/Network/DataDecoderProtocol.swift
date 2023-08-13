import Foundation

//sourcery: AutoMockable
/// A protocol defining the contract for a data decoder.
public protocol DataDecoderProtocol {
    /// Decodes the given data into an instance of the specified type.
    /// - Parameters:
    ///   - data: The data to decode.
    ///   - type: The type of the object to decode into.
    /// - Returns: The decoded object of the specified type.
    /// - Throws: An error if decoding fails.
    func decode<T: Decodable>(_ data: Data, type: T.Type) throws -> T
}

/// A data decoder implementation for JSON data.
public final class JsonDecoder: DataDecoderProtocol {
    let decoder: JSONDecoder

    /// Initializes a new instance of the JSON decoder with an optional custom JSON decoder.
    /// - Parameter decoder: The JSON decoder to use. If not provided, a default JSON decoder is used.
    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }

    public func decode<T>(_ data: Data, type: T.Type) throws -> T where T: Decodable {
        return try decoder.decode(T.self, from: data)
    }
}
