//
//  FeedDetail.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Domain

enum FeedDetail {
    struct State: StateProtocol {
        var news: News
        var isBookmarked: Bool
    }

    enum Action {
        case toggleBookmarked
    }

    enum Destination {}
}
