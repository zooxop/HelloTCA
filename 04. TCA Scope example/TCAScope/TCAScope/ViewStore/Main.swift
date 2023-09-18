//
//  Main.swift
//  TCAScope
//
//  Created by 문철현 on 2023/09/04.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Main
struct MainView: View {
  let store: StoreOf<MainFeature>
  @ObservedObject var viewStore: ViewStore<MainFeature.State, MainFeature.Action>
  
  init(store: StoreOf<MainFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    HStack(spacing: 30.0) {
      VStack {
        Text(viewStore.title)
          .font(.title)
        
        Text(viewStore.subState.value.description)
        
        Button("button") {
          viewStore.send(.tappedAction)
        }
      }
      
      SubView(
        store: self.store.scope(
          state: \.subState,
          action: MainFeature.Action.subAction
        )
      )
    }
    .padding()
    .background(Color.blue.opacity(0.2))
  }
}

struct MainFeature: Reducer {
  struct State: Equatable {
    static let initialState: State = State(
      title: "Main View"
    )
    
    var title: String
    var subState: SubFeature.State = .init()
  }
  
  enum Action: Equatable {
    case tappedAction
    case subAction(SubFeature.Action)
  }
  
  var body: some Reducer<State, Action> {
    Scope(state: \.subState, action: /Action.subAction) {
      SubFeature()
    }
    
    Reduce { state, action in
      switch action {
      case .tappedAction:
        print("Main View Button Tapped.")
        return .none
        
      case .subAction(.buttonTapped):
        print("Sub View Button Tapped. (Here is MainView)")
        return .none
        
      }
    }
  }
}
