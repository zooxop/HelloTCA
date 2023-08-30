//
//  HomeFeature.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture

struct HomeFeature: Reducer {
  struct State: Equatable {
    static let initialState = State()
  }
  
  enum Action {
    case nextButtonTapped
  }
  
  var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
