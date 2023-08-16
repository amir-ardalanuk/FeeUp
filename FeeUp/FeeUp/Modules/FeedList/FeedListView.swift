//
//  FeedListView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import SwiftUI
import Domain

struct FeedListView: View {
    @State private var state: FeedList.State?
    let viewModel: any FeedListViewModelProtocol

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(state?.newsList ?? [], id: \.self) { value in
                            FeedRowView(news: value).frame(height: 100)
                        }
                    }
                }
            }.searchable(text: .init(get: {
                state?.search ?? ""
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
