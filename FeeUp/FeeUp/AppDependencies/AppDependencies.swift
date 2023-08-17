//
//  AppDependencies.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/16/23.
//

import Foundation
import Repository
import Domain
import SwiftUI

protocol AppDependencies {
    var dependencies: Dependencies { get }
}

private struct AppDependencyEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppDependencies = AppDI.shared
}

extension EnvironmentValues {
    var appDependencyValue: AppDependencies {
        get { self[AppDependencyEnvironmentKey.self] }
        set { self[AppDependencyEnvironmentKey.self] = newValue }
    }
}

final class AppDI: AppDependencies {
    static let shared: AppDependencies = AppDI()

    lazy var dependencies: Dependencies = {
        DependencyManager()
    }()

    private init() {}
}
