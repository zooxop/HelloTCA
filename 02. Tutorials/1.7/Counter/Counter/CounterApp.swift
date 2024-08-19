//
//  CounterApp.swift
//  Counter
//
//  Created by 문철현 on 8/17/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct CounterApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(
        store: Store(initialState: CounterFeature.State()) {
          CounterFeature()
        }
      )
    }
  }
}
