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

    var state: FeedList.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<FeedList.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<FeedList.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init() {
        self.stateSubject = .init(.init(newsList: [], isLoadingList: true))
        self.destinationSubject = .init()
    }

    func handle(action: FeedList.Action) {}
}
