//
//  SignInFeature.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture

struct SignInFeature: Reducer {
  struct State: Equatable {
    
  }
  
  enum Action {
    case signInTapped
  }
  
  var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
