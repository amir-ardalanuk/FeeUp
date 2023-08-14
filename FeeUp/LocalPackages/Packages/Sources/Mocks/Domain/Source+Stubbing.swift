import Foundation
import Domain

public extension Source {
    static func stub(id: String = UUID().uuidString, name: String = "name") -> Self {
        Source(id: id, name: name)
    }
}
