//
//  AppFeatureTests.swift
//  CounterTests
//
//  Created by 문철현 on 8/20/24.
//

import ComposableArchitecture
import XCTest

@testable import Counter

final class AppFeatureTests: XCTestCase {
  
  @MainActor
  func testIncrementInFirstTab() async {
    let store = TestStore(initialState: AppFeature.State()) {
      AppFeature()
    }
    
    await store.send(\.tab1.incrementButtonTapped) {
      $0.tab1.count = 1
    }
  }
}
