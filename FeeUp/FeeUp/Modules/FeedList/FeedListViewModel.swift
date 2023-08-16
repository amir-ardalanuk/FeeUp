//
//  FeedListViewModel.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Domain
import Combine

typealias FeedListViewModelProtocol = ViewModel<FeedList.State, FeedList.Action, FeedList.Destination>

final class FeedListViewModel: ViewModel {
    // MARK: typealias
    typealias State = FeedList.State
    typealias Action = FeedList.Action
    typealias Destination = FeedList.Destination
    // MARK: properties
    private let stateSubject: CurrentValueSubject<FeedList.State, Never>
    private let destinationSubject: PassthroughSubject<FeedList.Destination, Never>
    private let feedUsecases: FeedUsecases
    private var currentQuery: FeedQuery

    var state: FeedList.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<FeedList.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<FeedList.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init(feedUsecases: FeedUsecases) {
        self.feedUsecases = feedUsecases
        self.stateSubject = .init(.init(newsList: [], isLoadingList: true, search: nil))
        self.destinationSubject = .init()
        self.currentQuery = .init()
    }

    func handle(action: FeedList.Action) {
        switch action {
        case let .search(text):
            stateSubject.value.update { $0.search = text }
        case .fetchLatestFeed:
            fetchLatestFeed()
        }
    }

    private func fetchLatestFeed() {
        Task {
            do {
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                stateSubject.value.update { $0.newsList = result }
            } catch {
                print(error)
            }

        }

    }
}
