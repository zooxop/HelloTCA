//
//  SignOutView.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture
import SwiftUI

struct SignOutView: View {
  let store: StoreOf<SignOutFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Text("Sign Out View")
          .padding()
        
        Button("Sign out") {
          viewStore.send(.goToSignInTapped)
        }
      }
    }
  }
}
