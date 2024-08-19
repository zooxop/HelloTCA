//
//  CounterFeature.swift
//  Counter
//
//  Created by 문철현 on 8/17/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterFeature {
  
  @Dependency(\.continuousClock) var clock
  
  // 기능을 구현하기 위한 변수를 State에 만들어준다.
  @ObservableState
  struct State {
    var count: Int = 0
    var isTimerOn: Bool = false
    var fact: String?
    var isLoading: Bool = false
  }
  
  enum Action: Equatable {
    // 숫자 증감버튼들을 탭할때의 상황
    case incrementButtonTapped
    case decrementButtonTapped
    case timerToggleTapped
    case timerTicked
    case factButtonTapped
    case factResponse(String)
  }
  
  private enum CancelID {
    case timer
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .timerTicked:
        state.count += 1
        state.fact = nil
        return .none
        
      case .decrementButtonTapped:
        state.count -= 1
        state.fact = nil
        return .none
        
      case .incrementButtonTapped:
        state.count += 1
        state.fact = nil
        return .none
        
      case .timerToggleTapped:
        state.isTimerOn.toggle()
        if state.isTimerOn {
          return .run { send in
            // 주입된 의존성 활용
            for await _ in self.clock.timer(interval: .seconds(1)) {
              await send(.timerTicked)
            }
          }
          .cancellable(id: CancelID.timer)
        } else {
          // Stop the timer
          return .cancel(id: CancelID.timer)
        }
        
      case .factButtonTapped:
        state.fact = nil
        state.isLoading = true
        
        return .run { [count = state.count, isTimerOn = state.isTimerOn] send in
          if isTimerOn {
            await send(.timerToggleTapped)
          }
          
          let (data, _) = try await URLSession.shared
            .data(from: URL(string: "http://numbersapi.com/\(count)")!)
          
          let fact = String(decoding: data, as: UTF8.self)
          await send(.factResponse(fact))
        }
        
      case .factResponse(let fact):
        state.fact = fact
        state.isLoading = false
        
        return .none
        
      }
    }
  }
  
//  위의 body 클로저 또는, 아래 reduce 함수 둘 중 한 가지 방법으로 구현한다.
//  func reduce(into state: inout State, action: Action) -> Effect<Action> {
//    switch action {
//    case .decrementButtonTapped:
//      state.count -= 1
//      return .none
//
//    case .incrementButtonTapped:
//      state.count += 1
//      return .none
//    }
//  }
  
}
