//
//  FeedRowView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/13/23.
//

import SwiftUI


struct FeedRowView: View {
    enum Constants {
        static let padding = 10.0
        static let spacing = 10.0
        static let innerSpacing = 8.0
        static let radius = 8.0
    }

    var body: some View {
        HStack(spacing: Constants.spacing) {
            Color.gray
                .overlay(
                    // You can load the image asynchronously from the web using a SwiftUI remote image view
                    Image(systemName: "circule")
                        .aspectRatio(contentMode: .fill)
                )
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: Constants.radius))

            // News Details
            VStack(alignment: .leading, spacing: Constants.spacing) {
                Text("title")
                    .font(.headline)
                Spacer()
                HStack {
                    Text("date")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("source")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }.padding(.vertical, 8.0)
        }
        .padding(10)
    }
}

struct FeedRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedRowView()
        }.previewLayout(.fixed(width: 320, height: 100))
    }
}
