//
//  CountryList.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Domain

enum CountryList {
    struct State: StateProtocol {
        var countryList: FeedCountries
        var currentSelected: FeedCountry?
    }
    enum Action {
        case fetchCountries
    }
    enum Destination {}
}
