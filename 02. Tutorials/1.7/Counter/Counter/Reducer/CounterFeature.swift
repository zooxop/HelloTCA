//
//  CounterFeature.swift
//  Counter
//
//  Created by 문철현 on 8/17/24.
//

import ComposableArchitecture

@Reducer
struct CounterFeature {
  
  @Dependency(\.continuousClock) var clock
  
  // 기능을 구현하기 위한 변수를 State에 만들어준다.
  @ObservableState
  struct State {
    var count: Int = 0
    var isTimerOn: Bool = false
  }
  
  enum Action: Equatable {
    // 숫자 증감버튼들을 탭할때의 상황
    case incrementButtonTapped
    case decrementButtonTapped
    case timerToggleTapped(Bool)
    case timerTicked
  }
  
  private enum CancelID {
    case timer
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .timerTicked:
        state.count += 1
        return .none
        
      case .decrementButtonTapped:
        state.count -= 1
        return .none
        
      case .incrementButtonTapped:
        state.count += 1
        return .none
        
      case .timerToggleTapped(let isEnabled):
        state.isTimerOn = isEnabled
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
