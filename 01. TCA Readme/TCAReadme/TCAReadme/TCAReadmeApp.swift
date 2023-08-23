//
//  TCAReadmeApp.swift
//  TCAReadme
//
//  Created by 문철현 on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAReadmeApp: App {
    var body: some Scene {
        WindowGroup {
            FeatureView(
                store: Store(initialState: Feature.State()) {
                    Feature()
                }
            )
        }
    }
}
