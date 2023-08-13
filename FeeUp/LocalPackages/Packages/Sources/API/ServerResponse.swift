import Foundation

struct ServerResponse<T: Decodable>: Decodable {
    let status: String
    let totalResults: Int
    let articles: T
}
