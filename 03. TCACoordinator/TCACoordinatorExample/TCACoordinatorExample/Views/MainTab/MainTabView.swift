//
//  MainTabView.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
  let store: StoreOf<MainTabFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: \.selectedTab) { viewStore in
      TabView(selection: viewStore.binding(get: { $0 }, send: MainTabFeature.Action.tabSelected)) {
        HomeView(
          store: store.scope(
            state: { $0.home },
            action: { .home($0) }
          )
        )
        .tabItem { Image(systemName: "house") }
        .tag(MainTabFeature.Tab.home)
        
        StatsView(
          store: store.scope(
            state: { $0.stats },
            action: { .stats($0) }
          )
        )
        .tabItem { Image(systemName: "chart.bar") }
        .tag(MainTabFeature.Tab.stats)
        
        SettingsView(
          store: store.scope(
            state: { $0.settings },
            action: { .settings($0) }
          )
        )
        .tabItem { Image(systemName: "gear") }
        .tag(MainTabFeature.Tab.settings)
      }
    }
  }
}
