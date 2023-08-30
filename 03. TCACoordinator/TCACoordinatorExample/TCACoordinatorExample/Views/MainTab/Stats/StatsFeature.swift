//
//  StatsFeature.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture

struct StatsFeature: Reducer {
  struct State: Equatable {
    static let initialState = State()
  }
  
  enum Action: Equatable {
    case helloButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
