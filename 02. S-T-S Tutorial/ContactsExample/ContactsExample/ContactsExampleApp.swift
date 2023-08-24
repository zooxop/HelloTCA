//
//  ContactsExampleApp.swift
//  ContactsExample
//
//  Created by 문철현 on 2023/08/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct ContactsExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContactsView(store: Store(initialState: ContactsFeature.State()) {
                    ContactsFeature()
                }
            )
        }
    }
}
