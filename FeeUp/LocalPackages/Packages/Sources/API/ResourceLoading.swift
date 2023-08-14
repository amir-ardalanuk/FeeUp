import Foundation

enum ResourceLoadingError: Error {
    case thereIsNotSuchFile
}

//sourcery: AutoMockable
public protocol ResourceLoading {
    func data(forResource: String?, withExtension: String?) throws -> Data?
}

extension Bundle: ResourceLoading {
    public func data(forResource resource: String?, withExtension: String?) throws -> Data? {
        guard let url = url(forResource: resource, withExtension: withExtension) else {
            throw ResourceLoadingError.thereIsNotSuchFile
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            throw error
        }
    }
}
