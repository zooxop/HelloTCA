//
//  SettingsView.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture
import SwiftUI

struct SettingsView: View {
  let store: StoreOf<SettingsFeatrue>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Text("Settings View")
          .padding()
        
        Button("Go to Sign Out View") {
          viewStore.send(.signOutTapped)
        }
      }
    }
  }
}
