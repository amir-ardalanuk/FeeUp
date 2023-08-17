//
//  FeedList.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Domain

enum FeedList {
    struct State: StateProtocol {
        var newsList: [News]
        var isLoadingList: Bool
        var hasLoadMore: Bool
        var isLoadingMore: Bool
        var search: String?
        var errorMessage: String?
        var selectedCountry: FeedCountry?
    }

    enum Action {
        case search(String)
        case fetchLatestFeed
        case loadNextPage
        case changeCountry(FeedCountry)
        case fetchCountries
    }

    enum Destination {}
}

extension FeedQuery: StateProtocol { }
