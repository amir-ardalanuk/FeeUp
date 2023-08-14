import Foundation

open class MockJsonDecoder: JSONDecoder {

    public override init() {
        super.init()
    }

    open var decodeHandler: (() throws -> Any)?
    open override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        guard let handler = decodeHandler else {
            throw NSError(domain: "Do not use decodeHandler", code: 100)
        }

        let model = try handler()
        return model as! T
    }
}
