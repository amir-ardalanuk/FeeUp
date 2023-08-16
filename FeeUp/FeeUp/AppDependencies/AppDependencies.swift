//
//  AppDependencies.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Repository
import Domain

protocol AppDependencies {
    var dependencies: Dependencies { get }
}

final class AppDI: AppDependencies {
    static let shared: AppDependencies = AppDI()

    lazy var dependencies: Dependencies = {
        DependencyManager()
    }()

    private init() {}
}
