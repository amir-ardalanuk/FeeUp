//
//  CategoryList.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/17/23.
//

import Foundation
import Domain

enum CategoryList {
    struct State: StateProtocol {
        var categoryList: FeedCategories
        var currentSelected: FeedCategory?
    }
    enum Action {
        case fetchCategories
    }
    enum Destination {}
}
