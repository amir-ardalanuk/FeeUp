//
//  FeedDetailView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import SwiftUI
import Domain

struct FeedDetailView: View {
    @State private var state: FeedDetail.State
    let viewModel: any FeedDetailViewModelProtocol

    init(viewModel: any FeedDetailViewModelProtocol) {
        self.viewModel = viewModel
        self._state = .init(initialValue: viewModel.state) 
    }

    var body: some View {
        NavigationView {
                ScrollView {
                    remoteView()
                    VStack(alignment: .leading, spacing: 12.0) {
                        Text(state.news.title ?? "-").font(.title)
                        Text("Author: \(state.news.author ?? "-")").font(.caption2)
                        Text("Published at: \(state.news.publishedAt.formatted())").font(.caption2)
                        Text(state.news.content ?? "-").font(.caption)
                    }.padding()

                }
        }.toolbar {
            Button(action: {
                viewModel.handle(action: .toggleBookmarked)
            }, label: {
                Image(systemName: state.isBookmarked ? "heart.fill" : "heart")
            }).foregroundColor(.red)
        }.navigationTitle(state.news.title ?? "Detail")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.statePublisher.receive(on: DispatchQueue.main)) { state in
                self.state = state
            }
    }

    @ViewBuilder
    func remoteView() -> some View {
        if let urlString = state.news.urlToImage, let url = URL(string: urlString) {
            RemoteImage(url: url)
        } else {
            EmptyView()
        }
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    struct FeedBookmarkUsecasesMock: FeedBookmarkUsecases {

        func bookmark(news: Domain.News) async throws {
        }

        func removeBookmark(news: Domain.News) async throws {

        }

        func isBookmarked(news: Domain.News) throws -> Bool {
            return true
        }

    }

    static var previews: some View {
        let news: News = .init(source: .init(id: "", name: "name"), title: "title", description: "dsc", url: "url", publishedAt: .now, content: "content")
        return FeedDetailView(viewModel: FeedDetailViewModel(news: news, feedBookmarkUsecases: FeedBookmarkUsecasesMock()))
    }
}
