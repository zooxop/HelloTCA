//
//  SignInView.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct SignInView: View {
  let store: StoreOf<SignInFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Button("Sign In") {
          viewStore.send(.signInTapped)
        }
      }
    }
  }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView(
      store: Store(initialState: SignInFeature.State()) {
        SignInFeature()
      }
    )
  }
}
#endif
