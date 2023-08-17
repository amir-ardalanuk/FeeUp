//
//  CategoryListView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/18/23.
//

import SwiftUI

import Domain
import SwiftUI

struct CategoryListView: View {
    @State private var state: CategoryList.State
    let viewModel: any CategoryListViewModelProtocol
    var action: (FeedCategory?) -> Void
    init(viewModel: any CategoryListViewModelProtocol, action: @escaping (FeedCategory?) -> Void) {
        self.action = action
        self.viewModel = viewModel
        self._state = .init(initialValue: viewModel.state)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Button(action: {
                        action(nil)
                    }, label: {
                        rowView(title: "None.", isSelected: state.currentSelected?.key == nil, emoji: "📦")
                    })
                    ForEach(state.categoryList, id: \.key) { category in
                        Button(action: {
                            action(category)
                        }, label: {
                            rowView(title: category.name, isSelected: category.key == state.currentSelected?.key, emoji: category.emoji)
                        })
                    }
                }
            }.navigationTitle("Category List")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(viewModel.statePublisher.receive(on: DispatchQueue.main)) { state in
                    self.state = state
                }
                .onAppear {
                    viewModel.handle(action: .fetchCategories)
                }
        }
    }

    @ViewBuilder
    func rowView(title: String, isSelected: Bool, emoji: String) -> some View {
        HStack {
            if isSelected {
                Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
            } else {
                Image(systemName: "checkmark.seal").hidden()
            }
            Text(emoji)
            Text(title)
            Spacer()
        }.foregroundColor(.black).padding()
    }
}

struct CategoryListView_Previews: PreviewProvider {
    struct FeedUsecasesMock: FeedUsecases {
        func categories() async throws -> Domain.FeedCategories {
            return [.init(key: "key", name: "name", emoji: "")]
        }

        func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News] {
            []
        }

        func countries() async throws -> FeedCountries {
            return []
        }
    }

    static var previews: some View {
        return CategoryListView(viewModel: CategoryListViewModel(defaultSelected: .init(key: "key", name: "name", emoji: ""), feedUsecases: FeedUsecasesMock()), action: { _ in

        })
    }
}
