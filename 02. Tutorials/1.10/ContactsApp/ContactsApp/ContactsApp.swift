//
//  ContactsAppApp.swift
//  ContactsApp
//
//  Created by 문철현 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct ContactsApp: App {
  static let store = Store(initialState: ContactsFeature.State()) {
    ContactsFeature()
  }
  
  var body: some Scene {
    WindowGroup {
      ContactsView(store: ContactsApp.store)
    }
  }
}
