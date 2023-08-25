//
//  CounterExampleApp.swift
//  CounterExample
//
//  Created by 문철현 on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct CounterExampleApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()  // Reducer가 처리하는 모든 Action을 Console에 출력함.
    }
    var body: some Scene {
        WindowGroup {
            CounterView(store: CounterExampleApp.store)
        }
    }
}
