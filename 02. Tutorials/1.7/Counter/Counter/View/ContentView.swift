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
        
        HStack {
          counterEffectButton("Fact") {
            store.send(.factButtonTapped)
          }
          .background(.blue.opacity(0.8))
          .clipShape(.capsule)
          
          
          counterEffectButton("Timer") {
            store.send(.timerToggleTapped)
          }
          .background(store.isTimerOn ? .green.opacity(0.8) : .orange.opacity(0.8))
          .clipShape(.capsule)
        }
        
        HStack {
          if store.isLoading {
            ProgressView()
          } else if let fact = store.fact {
            Text(fact)
              .font(.headline)
              .multilineTextAlignment(.center)
              .padding()
          }
        }
        .frame(minHeight: 40)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

extension ContentView {
  private func counterButton(_ title: String, _ action: @escaping () -> Void) -> some View {
    Button(title) {
      action()
    }
    .font(.largeTitle)
    .padding()
    .background(.black.opacity(0.1))
    .clipShape(.rect(cornerRadius: 10))
  }
  
  private func counterEffectButton(_ title: String, _ action: @escaping () -> Void) -> some View {
    Button(title) {
      action()
    }
    .font(.title3)
    .padding()
    .foregroundStyle(.white)
  }
}

#Preview {
  ContentView(store: Store(initialState: CounterFeature.State()) {
    CounterFeature()
  })
}
