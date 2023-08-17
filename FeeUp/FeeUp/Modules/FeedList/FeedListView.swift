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
    @Environment(\.appDependencyValue) var appDependencies: AppDependencies
    @State private var showingCountrySheet = false
    @State private var state: FeedList.State
    let viewModel: any FeedListViewModelProtocol

    init(viewModel: any FeedListViewModelProtocol) {
        self.viewModel = viewModel
        self._state = .init(initialValue: viewModel.state)
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        if state.errorMessage != nil {
                            Text("Can't fetch news for \(state.errorMessage ?? "unknown")").foregroundColor(.red)
                        }
                        if state.isLoadingList {
                            Text("Fetching latest News ...")
                        }

                        if !state.isLoadingList, state.errorMessage == nil, state.newsList.isEmpty {
                            Text("Can't Find any news ...")
                        }
                        ForEach(state.newsList, id: \.self) { value in
                            NavigationLink(value: value) {
                                FeedRowView(news: value).frame(height: 100).foregroundColor(.black)
                            }
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
                .onReceive(viewModel.statePublisher.receive(on: DispatchQueue.main)) { state in
                    self.state = state
                }
                .navigationDestination(for: News.self) { news in
                    FeedDetailView(viewModel: FeedDetailViewModel(news: news, feedBookmarkUsecases: appDependencies.dependencies.feedBookmarkUsecases))
                }
                .toolbar {
                    Button(action: {
                        showingCountrySheet = true
                    }, label: {
                        Text("\(state.selectedCountry?.flag ?? "Loading")")
                    })
                }
        }.onAppear {
            viewModel.handle(action: .fetchCountries)
        }.sheet(isPresented: $showingCountrySheet) {
            CountryListView(viewModel: CountryListViewModel(defaultSelected: state.selectedCountry, feedUsecases: appDependencies.dependencies.feedUsecases)) { new in
                showingCountrySheet = false
                viewModel.handle(action: .changeCountry(new))
            }
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
