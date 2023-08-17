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
@testable import FeeUp

final class FeedListViewModelTest: XCTestCase {
    var sut: FeedListViewModel!
    var feedUsecasesMock: FeedUsecasesMock!

    override func setUp() {
        super.setUp()
        feedUsecasesMock = .init()
        sut = .init(feedUsecases: feedUsecasesMock)
    }

    override func tearDown() {
        super.tearDown()
        feedUsecasesMock = nil
        sut = nil
    }
}

// MARK: - test search action
extension FeedListViewModelTest {
    func test_searchAction_whenTextIsEmpty() async {
        let expectation = expectation(description: "test search")
        let query = FeedQuery(country: .init(key: "us", name: "USA", flag: ""))
        let newsStub: News = .stub()
        feedUsecasesMock.given(.fetchLatest(query: .value(query), willReturn: [newsStub]))
        feedUsecasesMock.perform(FeedUsecasesMock.Perform.fetchLatest(query: .value(query), perform: { query in
            expectation.fulfill()
        }))
        await sut.handle(action: .search(""))
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(sut.state.isLoadingList, false)
        XCTAssertEqual(sut.state.isLoadingMore, false)
        XCTAssertEqual(sut.state.search, nil)
    }

    func test_searchAction_dataArrviedSuccessfully() async {
        let expectation = expectation(description: "test search")
        let searchText = "text"
        let query = FeedQuery(country: .init(key: "us", name: "USA", flag: ""), query: searchText)
        let newsStub = News.stub()

        feedUsecasesMock.given(.fetchLatest(query: .value(query), willReturn: [newsStub]))


        var resultState: [FeedList.State] = []
        let cancellable = sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.isLoadingList == false {
                expectation.fulfill()
            }
        }
        await sut.handle(action: .search(searchText))
        await fulfillment(of: [expectation], timeout: 1.5)
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
        let query = FeedQuery(country: .init(key: "us", name: "USA", flag: ""), query: searchText)
        let localError = NSError(domain: "Server error", code: 500)

        feedUsecasesMock.given(.fetchLatest(query: .value(query), willThrow: localError))


        var resultState: [FeedList.State] = []
        let cancellable = sut.statePublisher.dropFirst().sink { state in
            resultState.append(state)
            if state.isLoadingList == false {
                expectation.fulfill()
            }
        }
        await sut.handle(action: .search(searchText))
        await fulfillment(of: [expectation], timeout: 1.5)
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
}
