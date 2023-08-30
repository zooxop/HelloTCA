//
//  Screen.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct Screen: Reducer {
  enum State: Equatable, Identifiable {
    case signIn(SignInFeature.State)
    case mainTab(MainTabFeature.State)
    case home(HomeFeature.State)
    case stats(StatsFeature.State)
    case settings(SettingsFeatrue.State)
    case signOut(SignOutFeature.State)
    
    var id: ID {
      switch self {
      case .signIn:
        return .signIn
        
      case .mainTab:
        return .mainTab
        
      case .home:
        return .home
        
      case .stats:
        return .stats
        
      case .settings:
        return .settings
        
      case .signOut:
        return .signOut
      }
    }
    
    enum ID: Identifiable {
      case signIn
      case mainTab
      case home
      case stats
      case settings
      case signOut
      
      var id: ID {
        self
      }
    }
  }
  
  enum Action {
    case signIn(SignInFeature.Action)
    case mainTab(MainTabFeature.Action)
    case home(HomeFeature.Action)
    case stats(StatsFeature.Action)
    case settings(SettingsFeatrue.Action)
    case signOut(SignOutFeature.Action)
  }
  
  var body: some ReducerOf<Self> {
    Scope(state: /State.signIn, action: /Action.signIn) {
      SignInFeature()
    }
    Scope(state: /State.mainTab, action: /Action.mainTab) {
      MainTabFeature()
    }
    Scope(state: /State.home, action: /Action.home) {
      HomeFeature()
    }
    Scope(state: /State.stats, action: /Action.stats) {
      StatsFeature()
    }
    Scope(state: /State.settings, action: /Action.settings) {
      SettingsFeatrue()
    }
    Scope(state: /State.signOut, action: /Action.signOut) {
      SignOutFeature()
    }
  }
}
