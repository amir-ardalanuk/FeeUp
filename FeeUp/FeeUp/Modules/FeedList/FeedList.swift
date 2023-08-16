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
        let newsList: [News]
        let isLoadingList: Bool
    }

    enum Action { }

    enum Destination {}
}
