//
//  CategoryViewModel.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Combine
import Domain

typealias CategoryListViewModelProtocol = ViewModel<CategoryList.State, CategoryList.Action, CategoryList.Destination>

final class CategoryListViewModel: ViewModel {
    // MARK: typealias
    typealias State = CategoryList.State
    typealias Action = CategoryList.Action
    typealias Destination = CategoryList.Destination
    // MARK: properties
    private let stateSubject: CurrentValueSubject<CategoryList.State, Never>
    private let destinationSubject: PassthroughSubject<CategoryList.Destination, Never>
    private let feedUsecases: FeedUsecases
    var state: CategoryList.State { stateSubject.value }

    var destinationPublisher: AnyPublisher<CategoryList.Destination, Never> {
        destinationSubject.eraseToAnyPublisher()
    }

    var statePublisher: AnyPublisher<CategoryList.State, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    // MARK: - init
    init(defaultSelected: FeedCategory?, feedUsecases: FeedUsecases) {
        self.stateSubject = .init(.init(categoryList: []))
        self.destinationSubject = .init()
        self.feedUsecases = feedUsecases
    }

    func handle(action: CategoryList.Action) {
        switch action {
        case .fetchCategories:
            fetchCategories()
        }
    }

    private func fetchCategories() {
        Task {
            let result = try await feedUsecases.categories()
            stateSubject.value.update { $0.categoryList = result }
        }
    }
}
