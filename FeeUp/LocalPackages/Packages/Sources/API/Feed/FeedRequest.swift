import Network
import Domain

enum FeedRequest {
    case topHeadlines(FeedQuery)
}

extension FeedRequest: RequestProtocol {
    var host: String {
        "newsapi.org"
    }

    var path: String {
        "/v2/top-headlines"
    }

    var requestType: Network.RequestType {
        .GET
    }

    var urlParams: [String : String?] {
        var param = [String: String?]()
        switch self {
        case let .topHeadlines(model):
            param["pageSize"] = "\(model.pageSize)"
            param["page"] = "\(model.pageSize)"

            if let q = model.query {
                param["q"] = q
            }

            if let category = model.category {
                param["category"] = category.rawValue
            }

            if let country = model.country {
                param["country"] = country.key
            }
        }
        return param
    }

    var headers: [String : String] {
        return ["x-api-key": "3033ed1329a94705883d74395c78baf8"]
    }
}
