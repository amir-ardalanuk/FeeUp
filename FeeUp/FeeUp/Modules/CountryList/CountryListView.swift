//
//  CountryListView.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import SwiftUI
import Domain

struct CountryListView: View {
    @State private var state: CountryList.State
    let viewModel: any CountryListViewModelProtocol
    var action: (FeedCountry) -> Void
    init(viewModel: any CountryListViewModelProtocol, action:  @escaping (FeedCountry) -> Void) {
        self.action = action
        self.viewModel = viewModel
        self._state = .init(initialValue: viewModel.state)
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(state.countryList, id: \.key) { country in
                            Button(action: {
                                action(country)
                            }, label: {
                                HStack {
                                    if country.key == state.currentSelected?.key {
                                        Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
                                    } else {
                                        Image(systemName: "checkmark.seal").hidden()
                                    }
                                    Text("\(country.flag)")
                                    Text("\(country.name)")
                                    Spacer()
                                    Text("\(country.key)").foregroundColor(.gray)
                                }.foregroundColor(.black).padding()
                            })
                        }
                    }
                }
            }.navigationTitle("Country List")
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(viewModel.statePublisher.receive(on: DispatchQueue.main)) { state in
                    self.state = state
                }
                .onAppear {
                    viewModel.handle(action: .fetchCountries)
                }
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    struct FeedUsecasesMock: FeedUsecases {
        func fetchLatest(query: Domain.FeedQuery) async throws -> [Domain.News] {
            []
        }

        func countries() async throws -> FeedCountries {
            return [FeedCountry(key: "us", name: "USA", flag: "flag"),
             FeedCountry(key: "ae", name: "AE", flag: "flag")]
        }
    }

    static var previews: some View {
        return CountryListView(viewModel: CountryListViewModel(defaultSelected: FeedCountry(key: "us", name: "USA", flag: "flag"), feedUsecases: FeedUsecasesMock()), action: {_ in

        })
    }
}
