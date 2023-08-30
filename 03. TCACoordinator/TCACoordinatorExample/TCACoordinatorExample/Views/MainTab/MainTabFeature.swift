//
//  MainTabFeature.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture

struct MainTabFeature: Reducer {
  enum Tab: Hashable {
    case home
    case stats
    case settings
  }
  
  struct State: Equatable {
    static let initialState = State(
      home: .initialState,
      stats: .initialState,
      settings: .initialState,
      selectedTab: .home
    )
    
    var home: HomeFeature.State
    var stats: StatsFeature.State
    var settings: SettingsFeatrue.State
    
    var selectedTab: Tab
  }
  
  enum Action: Equatable {
    case home(HomeFeature.Action)
    case stats(StatsFeature.Action)
    case settings(SettingsFeatrue.Action)
    
    case tabSelected(Tab)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case .tabSelected(let tab):
        state.selectedTab = tab
        
      default:
        break
      }
      
      return .none
    }
  }
}
