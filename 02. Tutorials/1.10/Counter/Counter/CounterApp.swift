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
  static let store = Store(initialState: AppFeature.State()) {
    AppFeature()
  }
  
  var body: some Scene {
    WindowGroup {
      AppView(store: CounterApp.store)
    }
  }
}
