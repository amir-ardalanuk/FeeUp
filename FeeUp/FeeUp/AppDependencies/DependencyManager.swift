//
//  Dependencies.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Domain
import API
import Repository
import Network
import Persistence

protocol Dependencies {
    var feedUsecases: FeedUsecases { get }
    var feedBookmarkUsecases: FeedBookmarkUsecases { get }
}

final class DependencyManager: Dependencies {

    private lazy var feedAPI: FeedAPIProtocol = {
        FeedAPIUsecases(requestManager: RequestManager())
    }()

    private lazy var feedPersistencing: FeedPersistencing = {
        UserDefaultsFeedPersistence.init(userDefault: .standard, encoder: .init(), decoder: .init())
    }()

    private lazy var feedRepository: FeedRepository = {
        FeedRepository(feedAPI: feedAPI, feedBookmarkPersistence: feedPersistencing)
    }()

    var feedUsecases: FeedUsecases { feedRepository }

    var feedBookmarkUsecases: FeedBookmarkUsecases {  feedRepository }
}
