//
//  Coordinator.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

struct CoordinatorView: View {
  let store: StoreOf<Coordinator>
  
  var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) { screen in
        switch screen {
        case .signIn:
          CaseLet(
            /Screen.State.signIn,
             action: Screen.Action.signIn,
             then: SignInView.init
          )
          
        case .mainTab:
          CaseLet(
            /Screen.State.mainTab,
             action: Screen.Action.mainTab,
             then: MainTabView.init
          )
          
        case .home:
          CaseLet(
            /Screen.State.home,
             action: Screen.Action.home,
             then: HomeView.init
          )
          
        case .stats:
          CaseLet(
            /Screen.State.stats,
             action: Screen.Action.stats,
             then: StatsView.init
          )
          
        case .settings:
          CaseLet(
            /Screen.State.settings,
             action: Screen.Action.settings,
             then: SettingsView.init
          )
          
        case .signOut:
          CaseLet(
            /Screen.State.signOut,
             action: Screen.Action.signOut,
             then: SignOutView.init
          )
        }
      }
    }
  }
}

struct Coordinator: Reducer {
  
  struct State: Equatable, IdentifiedRouterState {
    static let initialState = State(
      routes: [.root(.signIn(.init()), embedInNavigationView: true)]
    )
    
    var routes: IdentifiedArrayOf<Route<Screen.State>>
  }
  
  enum Action: IdentifiedRouterAction {
    case routeAction(Screen.State.ID, action: Screen.Action)
    case updateRoutes(IdentifiedArrayOf<Route<Screen.State>>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .routeAction(_, action: .signIn(.signInTapped)):
        state.routes.presentCover(.mainTab(.initialState), embedInNavigationView: true)
        
      case .routeAction(_, action: .mainTab(.settings(.signOutTapped))):
        state.routes.push(.signOut(.initialState))
        
      case .routeAction(_, action: .signOut(.goToSignInTapped)):
        state.routes.goBackToRoot()
        
      default:
        break
      }
      
      return .none
    }.forEachRoute {
      Screen()
    }
  }
}

