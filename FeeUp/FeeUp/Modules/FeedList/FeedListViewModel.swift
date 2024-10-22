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
    private(set) var currentQuery: FeedQuery?
    private var searchTask: Task<Void, Error>?
    var state: FeedList.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<FeedList.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<FeedList.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init(query: FeedQuery? = nil, feedUsecases: FeedUsecases) {
        self.feedUsecases = feedUsecases
        // TODO: It's better to get countries then
        self.stateSubject = .init(.init(newsList: [], isLoadingList: true, hasLoadMore: false, isLoadingMore: false, search: nil, selectedCountry: nil))
        self.destinationSubject = .init()
        if let query {
            currentQuery = query
        }
    }

    @MainActor
    func handle(action: FeedList.Action) {
        switch action {
        case let .search(text):
            search(text: text)
        case .fetchLatestFeed:
            fetchLatestFeed()
        case .loadNextPage:
            fetchNextPage()
        case let .changeCountry(country):
            changeCountry(country)
        case .fetchCountries:
            fetchCountries()
        case let .changeCategory(cateogory):
            changeCategory(cateogory)
        }
    }

    private func fetchCountries() {
        Task {
            guard let first = try? await feedUsecases.countries().first else {
                return stateSubject.value.update { $0.errorMessage = "Cannot fetch countries"}
            }
            currentQuery = .init(country: first)
            stateSubject.value.update { $0.selectedCountry = first }
            await fetchLatestFeed()
        }

    }

    @MainActor
    private func changeCategory(_ category: FeedCategory?) {
        guard currentQuery != nil else { return }
        currentQuery?.update { $0.category = category }
        stateSubject.value.update { $0.selectedCategory = category }
        fetchLatestFeed()
    }

    @MainActor
    private func changeCountry(_ country: FeedCountry) {
        guard currentQuery != nil else { return }
        currentQuery?.update { $0.country = country }
        stateSubject.value.update { $0.selectedCountry = country }
        fetchLatestFeed()
    }

    @MainActor
    private func search(text: String) {
        searchTask?.cancel()
        guard !text.isEmpty else {
            return fetchLatestFeed()
        }
        stateSubject.value.update {
            $0.search = text
            $0.newsList = []
            $0.isLoadingList = true
            $0.errorMessage = nil
        }
        searchTask = Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            guard !Task.isCancelled else { return }
            currentQuery?.update {
                $0.page = 1
                $0.query = text
            }
            do {
                guard let currentQuery else {
                    return stateSubject.value.update {
                        $0.isLoadingList = false
                        $0.errorMessage = "Somthing goes wrong, refresh again"
                    }
                }
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                await MainActor.run {
                    stateSubject.value.update {
                        $0.newsList = result
                        $0.hasLoadMore = result.count == currentQuery.pageSize
                        $0.isLoadingList = false
                    }
                }
            } catch {
                stateSubject.value.update {
                    $0.errorMessage = error.localizedDescription
                    $0.isLoadingList = false
                }
            }
        }
    }

    @MainActor
    private func fetchNextPage() {
        stateSubject.value.update { $0.isLoadingMore = true }
        Task {
            currentQuery?.update { $0.page += 1 }
            do {
                guard let currentQuery else {
                    return stateSubject.value.update {
                        $0.isLoadingList = false
                        $0.errorMessage = "Somthing goes wrong, refresh again"
                    }
                }
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                await MainActor.run {
                    stateSubject.value.update {
                        $0.newsList += result
                        $0.hasLoadMore = result.count == currentQuery.pageSize
                        $0.isLoadingMore = false
                    }
                }
            } catch {
                currentQuery?.update { $0.page -= 1 }
                stateSubject.value.update {
                    $0.errorMessage = error.localizedDescription
                    $0.isLoadingMore = false
                }
            }
        }
    }

    @MainActor
    private func fetchLatestFeed() {
        stateSubject.value.update {
            $0.isLoadingList = true
            $0.errorMessage = nil
        }
        Task {
            do {
                currentQuery?.update {
                    $0.page = 1
                    $0.query = nil
                }
                guard let currentQuery else {
                     stateSubject.value.update {
                        $0.isLoadingList = false
                    }
                    return fetchCountries()
                }
                let result = try await feedUsecases.fetchLatest(query: currentQuery)
                await MainActor.run {
                    stateSubject.value.update {
                        $0.newsList = result
                        $0.isLoadingList = false
                        $0.hasLoadMore = result.count == currentQuery.pageSize
                    }
                }
            } catch {
                stateSubject.value.update {
                    $0.errorMessage = error.localizedDescription
                    $0.isLoadingList = false
                }
            }
        }
    }
}
