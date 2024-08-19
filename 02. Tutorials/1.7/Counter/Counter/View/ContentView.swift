//
//  ContentView.swift
//  Counter
//
//  Created by 문철현 on 8/17/24.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
  // let store: Store<CounterFeature.State, CounterFeature.Action>의 축약형이다.
  @Perception.Bindable var store: StoreOf<CounterFeature>
  
  var body: some View {
    WithPerceptionTracking {
      ZStack {
        VStack(alignment: .center, spacing: 20.0) {
          
          HStack(spacing: 20.0) {
            counterButton("-") {
              store.send(.decrementButtonTapped)
            }
            
            
            Text("\(store.count)")
              .font(.largeTitle)
            
            
            counterButton("+") {
              store.send(.incrementButtonTapped)
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        VStack(alignment: .center) {
          Toggle(isOn: $store.isTimerOn.sending(\.timerToggleTapped)) {
            Text("Timer")
          }
          .fixedSize()
        }
        .padding(.top, 150)
      }
    }
  }
}

extension ContentView {
  @ViewBuilder
  private func counterButton(_ title: String, _ action: @escaping () -> ()) -> some View {
    Button(title) {
      action()
    }
    .font(.largeTitle)
    .padding()
    .background(.black.opacity(0.1))
    .clipShape(.rect(cornerRadius: 10))
  }
}

#Preview {
  ContentView(store: Store(initialState: CounterFeature.State()) {
    CounterFeature()
  })
}
