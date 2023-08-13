import Network
import Domain

enum FeedRequest {
    case topHeadlines(TopHeadlines)
}

extension FeedRequest: RequestProtocol {
    var host: String {
        "https://newsapi.org"
    }

    var path: String {
        "/v2/top-headlines"
    }

    var requestType: Network.RequestType {
        .GET
    }

    var params: [String: Any] {
        var param = [String: Any]()
        switch self {
        case let .topHeadlines(model):
            param["pageSize"] = model.pageSize
            param["page"] = model.page

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
