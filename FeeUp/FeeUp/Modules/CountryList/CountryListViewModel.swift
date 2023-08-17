//
//  CountryListViewModel.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Combine
import Domain

typealias CountryListViewModelProtocol = ViewModel<CountryList.State, CountryList.Action, CountryList.Destination>

final class CountryListViewModel: ViewModel {
    // MARK: typealias
    typealias State = CountryList.State
    typealias Action = CountryList.Action
    typealias Destination = CountryList.Destination
    // MARK: properties
    private let stateSubject: CurrentValueSubject<CountryList.State, Never>
    private let destinationSubject: PassthroughSubject<CountryList.Destination, Never>
    private let feedUsecases: FeedUsecases
    var state: CountryList.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<CountryList.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<CountryList.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init(defaultSelected: FeedCountry?, feedUsecases: FeedUsecases) {
        self.stateSubject = .init(.init(countryList: [], currentSelected: defaultSelected))
        self.destinationSubject = .init()
        self.feedUsecases = feedUsecases
    }

    func handle(action: CountryList.Action) {
        switch action {
        case .fetchCountries:
            fetchCountries()
        }
    }

    private func fetchCountries() {
        Task {
            let countries = try await feedUsecases.countries()
            stateSubject.value.update { $0.countryList = countries }
        }
    }
}
