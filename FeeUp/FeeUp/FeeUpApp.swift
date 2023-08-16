//
//  FeeUpApp.swift
//  FeeUp
//
//  Created by Amir Ardalan on 8/13/23.
//

import SwiftUI

@main
struct FeeUpApp: App {
    let appDependencies: AppDependencies = AppDI.shared

    var body: some Scene {

        WindowGroup {
            FeedListView(viewModel: FeedListViewModel(feedUsecases: appDependencies.dependencies.feedUsecases))
        }
    }
}
