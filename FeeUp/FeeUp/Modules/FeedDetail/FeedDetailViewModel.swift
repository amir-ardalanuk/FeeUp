//
//  FeedDetailViewModel.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Combine
import Domain

typealias FeedDetailViewModelProtocol = ViewModel<FeedDetail.State, FeedDetail.Action, FeedDetail.Destination>

final class FeedDetailViewModel: ViewModel {

    // MARK: typealias
    typealias State = FeedDetail.State
    typealias Action = FeedDetail.Action
    typealias Destination = FeedDetail.Destination
    // MARK: properties
    private let stateSubject: CurrentValueSubject<FeedDetail.State, Never>
    private let destinationSubject: PassthroughSubject<FeedDetail.Destination, Never>
    private let feedUsecases: FeedBookmarkUsecases
    private let news: News
    var state: FeedDetail.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<FeedDetail.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<FeedDetail.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init(news: News, feedBookmarkUsecases: FeedBookmarkUsecases) {
        self.news = news
        self.feedUsecases = feedBookmarkUsecases
        let isBookmarked = (try? feedBookmarkUsecases.isBookmarked(news: news)) ?? false
        self.stateSubject = .init(.init(news: news, isBookmarked: isBookmarked))
        self.destinationSubject = .init()
    }

    func handle(action: FeedDetail.Action) {
        switch action {
        case .toggleBookmarked:
            toggleBookmark()
        }
    }

    private func toggleBookmark() {
        Task {
            let isBookmarked = try feedUsecases.isBookmarked(news: news)
            if isBookmarked {
                try await feedUsecases.removeBookmark(news: news)
                stateSubject.value.update { $0.isBookmarked = false }
            } else {
                try await feedUsecases.bookmark(news: news)
                stateSubject.value.update { $0.isBookmarked = true }
            }
        }

    }
}
