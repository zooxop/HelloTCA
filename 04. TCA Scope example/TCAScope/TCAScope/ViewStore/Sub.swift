//
//  Sub.swift
//  TCAScope
//
//  Created by 문철현 on 2023/09/05.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Sub
struct SubView: View {
  let store: StoreOf<SubFeature>
  @ObservedObject var viewStore: ViewStore<SubFeature.State, SubFeature.Action>
  
  init(store: StoreOf<SubFeature>) {
    self.store = store
    self.viewStore = ViewStore(self.store, observe: { $0 })
  }
  
  var body: some View {
    VStack {
      Text(viewStore.title)
        .font(.title)
      
      Text(viewStore.value.description)
      
      Button("SubView Button") {
        viewStore.send(.buttonTapped)
      }
      .padding()
    }
    .background(Color.green.opacity(0.2))
    .padding()
  }
}

struct SubFeature: Reducer {
  struct State: Equatable {
    
    var title: String = "Sub View"
    var value: Int = 0
  }
  
  enum Action: Equatable {
    case buttonTapped
  }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
      
    case .buttonTapped:
      print("Sub View Button Tapped. (Here is SubView)")
      state.value += 1
      return .none
    }
  }
}
