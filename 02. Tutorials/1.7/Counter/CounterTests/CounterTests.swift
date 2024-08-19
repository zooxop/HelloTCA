//
//  CounterTests.swift
//  CounterTests
//
//  Created by 문철현 on 8/19/24.
//

import ComposableArchitecture
import XCTest

@testable import Counter

final class CounterTests: XCTestCase {

  @MainActor
  func testCounter() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    }
    
    await store.send(.incrementButtonTapped) {
      $0.count = 1
    }
    
    await store.send(.decrementButtonTapped) {
      $0.count = 0
    }
  }
  
  @MainActor
  func testTimer() async {
    let clock = TestClock()
    
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    } withDependencies: {
      $0.continuousClock = clock
    }
    
    // Action(Task) Start
    await store.send(.timerToggleTapped) {
      $0.isTimerOn = true
    }
    
    await clock.advance(by: .seconds(1))
    await store.receive(\.timerTick) {
      $0.count = 1
    }
    
    // Action(Task) Stop
    await store.send(.timerToggleTapped) {
      $0.isTimerOn = false
    }
    
    // ❗️ async/await 동작이 포함된 Action은, 해당 동작의 run을 종료해주는 코드까지 작성해주어야 테스트에 성공한다.
  }
  
  /*
   // ❗️ 이 테스트는 반드시 실패한다. (매번 달라지는 서버의 응답을 예측할 수 없기 때문.)
   // 그리고, 인터넷 연결과 외부 서버의 가동 시간에 의존성이 생기기 때문에 테스트가 느려지고 불안정해질 수 있다.
   // -> 이상적이지 않다.
   
  @MainActor
  func testNumberFact() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    } withDependencies: {
      $0.numberFact.fetch = { "\($0) is a good number." }
    }
    
    await store.send(.factButtonTapped) {
      $0.isLoading = true
    }
    
    await store.receive(\.factResponse) {
      $0.isLoading = false
      $0.fact = "???"
    }
  }*/
  
  // Dependency를 이용해서, numberFact를 가져오는 API 호출 기능을 Mocking 하여 테스트를 수행한다.
  @MainActor
  func testNumberFact() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    } withDependencies: {
      // Mocking을 통해, 실제로 Network 요청 없이 테스트 코드가 수행되도록 한다.
      $0.numberFact.fetch = { "\($0) is a good numberrrr." }
    }
    
    await store.send(.factButtonTapped) {
      $0.isLoading = true
    }
    await store.receive(\.factResponse) {
      $0.isLoading = false
      $0.fact = "0 is a good numberrrr."
    }
  }
}
