//
//  StatsView.swift
//  TCACoordinatorExample
//
//  Created by 문철현 on 2023/08/30.
//

import ComposableArchitecture
import SwiftUI

struct StatsView: View {
  let store: StoreOf<StatsFeature>
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        Text("Stats View")
      }
    }
  }
}
