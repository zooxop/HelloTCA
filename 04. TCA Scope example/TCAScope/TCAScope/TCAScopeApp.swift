//
//  TCAScopeApp.swift
//  TCAScope
//
//  Created by 문철현 on 2023/09/04.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAScopeApp: App {
  var body: some Scene {
    WindowGroup {
      MainView(
        store: Store(initialState: .initialState) {
          MainFeature()
        }
      )
    }
  }
}
