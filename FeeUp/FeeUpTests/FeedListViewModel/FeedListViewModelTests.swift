//
//  FeedListViewModelTests.swift
//  FeeUpTests
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import XCTest
import Mocks
import Domain
import Combine
@testable import FeeUp

final class FeedListViewModelTest: XCTestCase {
    var sut: FeedListViewModel!
    var feedUsecasesMock: FeedUsecasesMock!
    var cancellables: Set<AnyCancellable>!
    enum Constant {
        static let country: FeedCountry = .init(key: "us", name: "USA", flag: "")
    }
    override func setUp() {
        super.setUp()
        feedUsecasesMock = .init()
        cancellables = .init()
    }

    override func tearDown() {
        super.tearDown()
        feedUsecasesMock = nil
        sut = nil
        cancellables = nil
    }
}

// MARK: - test search action
extension FeedListViewModelTest {
    func test_searchAction_whenTextIsEmptyVetifyCallFetchList() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let newsStub: News = .stub()
        feedUsecasesMock.given(.fetchLatest(query: .value(query), willReturn: [newsStub]))
        feedUsecasesMock.perform(FeedUsecasesMock.Perform.fetchLatest(query: .value(query), perform: { query in
            expectation.fulfill()
        }))

        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        await sut.handle(action: .search(""))
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.state.isLoadingMore, false)
        XCTAssertEqual(sut.state.search, nil)
    }

    func test_searchAction_dataArrviedSuccessfully() async {
        let expectation = expectation(description: "test search")
        let searchText = "text"
        let query = FeedQuery(country: Constant.country, query: searchText)
        let newsStub = News.stub()

        feedUsecasesMock.given(.fetchLatest(query: .value(query), willReturn: [newsStub]))


        var resultState: [FeedList.State] = []
        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.isLoadingList == false {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .search(searchText))
        await fulfillment(of: [expectation], timeout: 1.5)
        XCTAssertEqual(sut?.currentQuery?.query, searchText)
        // before call api
        XCTAssertEqual(resultState.first?.newsList, [])
        XCTAssertEqual(resultState.first?.isLoadingList, true)
        XCTAssertEqual(resultState.first?.search, searchText)

        // after call api
        XCTAssertEqual(resultState.last?.newsList, [newsStub])
        XCTAssertEqual(resultState.last?.isLoadingList, false)
        XCTAssertEqual(resultState.last?.search, searchText)
        XCTAssertEqual(resultState.last?.isLoadingMore, false)
    }

    func test_searchAction_whenThrowError() async {
        let expectation = expectation(description: "test search")
        let searchText = "text"
        let query = FeedQuery(country: Constant.country, query: searchText)
        let localError = NSError(domain: "Server error", code: 500)

        feedUsecasesMock.given(.fetchLatest(query: .value(query), willThrow: localError))

        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        var resultState: [FeedList.State] = []
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.isLoadingList == false {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .search(searchText))
        await fulfillment(of: [expectation], timeout: 1.5)
        XCTAssertEqual(sut?.currentQuery?.query, searchText)
        // before call api
        XCTAssertEqual(resultState.first?.newsList, [])
        XCTAssertEqual(resultState.first?.isLoadingList, true)
        XCTAssertEqual(resultState.first?.search, searchText)
        XCTAssertNil(resultState.first?.errorMessage)

        // after call api
        XCTAssertEqual(resultState.last?.newsList, [])
        XCTAssertEqual(resultState.last?.isLoadingList, false)
        XCTAssertEqual(resultState.last?.search, searchText)
        XCTAssertEqual(resultState.last?.isLoadingMore, false)
        XCTAssertEqual(resultState.last?.errorMessage, localError.localizedDescription)
    }

    func test_search_whenQueryIsEmpty() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)

        var resultState: [FeedList.State] = []
        sut = .init(query: nil, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.errorMessage != nil {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .search("any"))
        await fulfillment(of: [expectation], timeout: 1.5)
        feedUsecasesMock.verify(.fetchLatest(query: .any), count: .never)
        XCTAssertEqual(resultState.last?.errorMessage, "Somthing goes wrong, refresh again")
        XCTAssertEqual(resultState.last?.isLoadingList, false)
    }
}

// MARK: - fetchLatestFeed action
extension FeedListViewModelTest {
    func test_fetchLatestFeedAction_whenQueryIsEmpty() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let newsStub: News = .stub()
        let country = Constant.country
        var resultState: [FeedList.State] = []
        feedUsecasesMock.given(.countries(willReturn: [country]))
        feedUsecasesMock.given(.fetchLatest(query: .value(query), willReturn: [newsStub]))

        sut = .init(query: nil, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if !state.newsList.isEmpty {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .fetchLatestFeed)
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.countries(), count: .once)
        feedUsecasesMock.verify(.fetchLatest(query: .value(query)), count: .once)
        XCTAssertEqual(resultState.last?.isLoadingMore, false)
        XCTAssertEqual(resultState.last?.selectedCountry, country)
        XCTAssertEqual(resultState.last?.hasLoadMore, false)
    }

    func test_fetchLatestFeedAction_whenUsecaseThrowAnError() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        var resultState: [FeedList.State] = []
        let localError = NSError(domain: "Server Error", code: 500)
        feedUsecasesMock.given(.fetchLatest(query: .value(query), willThrow: localError))

        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.errorMessage != nil {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .fetchLatestFeed)
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .value(query)), count: .once)
        XCTAssertEqual(resultState.last?.errorMessage, localError.localizedDescription)
        XCTAssertEqual(resultState.last?.isLoadingList, false)
        XCTAssertEqual(resultState.last?.newsList, [])
    }
}
// MARK: - fetchNextPage action
extension FeedListViewModelTest {
    func test_fetchNextPageAction_whenQueryIsEmpty() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)

        var resultState: [FeedList.State] = []
        sut = .init(query: nil, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.errorMessage != nil {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .loadNextPage)
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .any), count: .never)
        XCTAssertEqual(resultState.last?.errorMessage, "Somthing goes wrong, refresh again")
        XCTAssertEqual(resultState.last?.isLoadingList, false)
    }

    func test_fetchNextPageAction_whenUsecaseThrowAnError() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let localError = NSError(domain: "Server Error", code: 500)
        let changedQuery = query.updated { $0.page += 1 }
        feedUsecasesMock.given(.fetchLatest(query: .value(changedQuery), willThrow: localError))

        var resultState: [FeedList.State] = []
        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.errorMessage != nil {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .loadNextPage)
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .value(changedQuery)), count: .once)
        XCTAssertEqual(resultState.last?.errorMessage, localError.localizedDescription)
        XCTAssertEqual(resultState.last?.isLoadingMore, false)
        XCTAssertEqual(sut.currentQuery?.page, query.page)
    }

    func test_fetchNextPageAction_whenUsecaseRetriveDataSuccessfully() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let localError = NSError(domain: "Server Error", code: 500)
        let changedQuery = query.updated { $0.page += 1 }
        let news = [News.stub()]
        feedUsecasesMock.given(.fetchLatest(query: .value(changedQuery), willReturn: news))

        var resultState: [FeedList.State] = []
        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if !state.newsList.isEmpty {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        await sut.handle(action: .loadNextPage)
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .value(changedQuery)), count: .once)
        XCTAssertEqual(resultState.last?.newsList, news)
        XCTAssertEqual(resultState.last?.hasLoadMore, false)
        XCTAssertEqual(sut.currentQuery?.page, changedQuery.page)
    }
    
}
// MARK: - changeCountry action
extension FeedListViewModelTest {
    func test_changeCountryAction() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let newCountry = FeedCountry(key: "sec", name: "sec", flag: "")

        var resultState: [FeedList.State] = []
        feedUsecasesMock.given(.fetchLatest(query: .value(query.updated { $0.country = newCountry}), willReturn: [.stub()]))
        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        feedUsecasesMock.perform(.fetchLatest(query: .value(query.updated { $0.country = newCountry}), perform: { _ in
            expectation.fulfill()
        }))
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
        }.store(in: &cancellables)
        await sut.handle(action: .changeCountry(newCountry))
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .value(query.updated { $0.country = newCountry})), count: .once)
        XCTAssertEqual(sut.currentQuery?.country, newCountry)
        XCTAssertEqual(resultState.last?.selectedCountry, newCountry)
    }
}

// MARK: - changeCateogry action
extension FeedListViewModelTest {
    func test_changeCategoryAction() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: Constant.country)
        let newCategory = FeedCategory(key: "test", name: "test", emoji: "")
        let newCategoryQuery = query.updated { $0.category = newCategory}
        var resultState: [FeedList.State] = []
        feedUsecasesMock.given(.fetchLatest(query: .value(newCategoryQuery), willReturn: [.stub()]))
        sut = .init(query: query, feedUsecases: feedUsecasesMock)
        feedUsecasesMock.perform(.fetchLatest(query: .value(newCategoryQuery), perform: { _ in
            expectation.fulfill()
        }))
        sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
        }.store(in: &cancellables)
        await sut.handle(action: .changeCategory(newCategory))
        await fulfillment(of: [expectation], timeout: 1.0)
        feedUsecasesMock.verify(.fetchLatest(query: .value(newCategoryQuery)), count: .once)
        XCTAssertEqual(sut.currentQuery?.category, newCategory)
        XCTAssertEqual(resultState.last?.selectedCategory, newCategory)
    }
}
