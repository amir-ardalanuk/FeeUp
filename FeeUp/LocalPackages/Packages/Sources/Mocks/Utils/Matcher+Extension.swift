import Foundation
import SwiftyMocky
import Network

public extension Matcher {
    func registerRequestProtocol() {
        register(RequestProtocol.self) { lhs, rhs in
            return lhs.host == rhs.host &&
                lhs.path == rhs.path &&
                lhs.headers == rhs.headers &&
                NSDictionary(dictionary: lhs.params).isEqual(to: rhs.params) &&
                NSDictionary(dictionary: lhs.urlParams).isEqual(to: rhs.urlParams) &&
                lhs.requestType == rhs.requestType
        }
    }
}
