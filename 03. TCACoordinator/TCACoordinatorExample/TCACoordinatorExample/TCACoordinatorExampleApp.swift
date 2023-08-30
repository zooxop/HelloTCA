//
//  TCACoordinatorExampleApp.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCACoordinatorExampleApp: App {
  var body: some Scene {
    WindowGroup {
      CoordinatorView(
        store: Store(initialState: .initialState) {
          Coordinator()
        }
      )
    }
  }
}
