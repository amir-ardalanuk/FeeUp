//
//  FeedListView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import SwiftUI
import Domain
import Combine

struct FeedListView: View {
    @State private var state: FeedList.State
    let viewModel: any FeedListViewModelProtocol

    init(viewModel: any FeedListViewModelProtocol) {
        self.viewModel = viewModel
        self.state = viewModel.state
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        if state.isLoadingList {
                            Text("Fetching latest News ...")
                        }

                        if !state.isLoadingList, state.newsList.isEmpty {
                            Text("Can't Find any news ...")
                        }
                        ForEach(state.newsList, id: \.self) { value in
                            FeedRowView(news: value).frame(height: 100)
                        }
                        if state.hasLoadMore {
                            Text("Loading More ...").onAppear {
                                viewModel.handle(action: .loadNextPage)
                            }
                        }
                    }
                }.refreshable(action: {
                    await refresh()
                })
            }.searchable(text: .init(get: {
                state.search ?? ""
            }, set: { text in
                viewModel.handle(action: .search(text))
            }), placement: SwiftUI.SearchFieldPlacement.automatic)
                .navigationTitle("FeeUP")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(viewModel.statePublisher) { state in
                    self.state = state
                }
        }.onAppear {
            viewModel.handle(action: .fetchLatestFeed)
        }
    }

    func refresh() async {
        var cancellabe: AnyCancellable? = nil
        await withCheckedContinuation { continuation in
            cancellabe = viewModel.statePublisher.dropFirst().first(where: { $0.isLoadingList == false }).sink { _ in
                continuation.resume()
            }
            viewModel.handle(action: .fetchLatestFeed)
        }
    }
}

// MARK: - Preview
struct FeedListView_Previews: PreviewProvider {
    struct FeedUsecasesMock: FeedUsecases {
        func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News] {
            (0...10).map { News(
                source: .init(id: "\($0)", name: "name"),
                title: "title",
                description: "desc",
                url: "url",
                publishedAt: .now,
                content: "text"
            ) }
        }

        func countries() async throws -> Domain.FeedCountries {
            []
        }
    }

    static var previews: some View {
        FeedListView(viewModel: FeedListViewModel(feedUsecases: FeedUsecasesMock()))
    }
}
