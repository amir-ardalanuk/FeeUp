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
        self.stateSubject = .init(.init(newsList: [], isLoadingList: true, hasLoadMore: false, isLoadingMore: false, search: nil))
        self.destinationSubject = .init()
        self.currentQuery = .init(country: .init(key: "us", name: "USA", flag: ""))
    }

    @MainActor
    func handle(action: FeedList.Action) {
        switch action {
        case let .search(text):
            stateSubject.value.update { $0.search = text }
        case .fetchLatestFeed:
            fetchLatestFeed()
        case .loadNextPage:
            fetchNextPage()
        }
    }

    @MainActor
    private func fetchNextPage() {
        stateSubject.value.update { $0.isLoadingMore = true }
        Task {
            currentQuery.update { $0.page += 1 }
            do {
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                await MainActor.run {
                    stateSubject.value.update {
                        $0.newsList += result
                        $0.hasLoadMore = result.count == currentQuery.pageSize
                        $0.isLoadingMore = false
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func fetchLatestFeed() {
        stateSubject.value.update { $0.isLoadingList = true }
        Task {
            do {
                currentQuery.update { $0.page = 1 }
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                await MainActor.run {
                    stateSubject.value.update {
                        $0.newsList = result
                        $0.isLoadingList = false
                        $0.hasLoadMore = result.count == currentQuery.pageSize
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
