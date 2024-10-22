//
//  FeedRowView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/13/23.
//

import SwiftUI
import Domain

struct FeedRowView: View {
    enum Constants {
        static let padding = 10.0
        static let spacing = 10.0
        static let innerSpacing = 8.0
        static let radius = 8.0
    }

    let news: News

    var body: some View {
        HStack(spacing: Constants.spacing) {

            Color.gray
                .overlay(remoteView())
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: Constants.radius))

            // News Details
            VStack(alignment: .leading, spacing: Constants.spacing) {
                Text(news.title ?? "-")
                    .font(.headline)
                    .minimumScaleFactor(0.8)
                    .multilineTextAlignment(.leading)
                HStack {
                    Text(news.publishedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(news.source.name ?? "-")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }.padding(.vertical, 8.0)
        }
        .padding(10)
    }

    @ViewBuilder
    func remoteView() -> some View {
        if let urlString = news.urlToImage, let url = URL(string: urlString) {
            RemoteImage(url: url)
        } else {
            EmptyView()
        }
    }
}

struct FeedRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedRowView(news: .init(source: .init(id: "", name: ""), title: "", description: "", url: "", publishedAt: .now, content: ""))
        }.previewLayout(.fixed(width: 320, height: 100))
    }
}
