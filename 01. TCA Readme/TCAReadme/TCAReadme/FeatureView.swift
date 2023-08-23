//
//  ContentView.swift
//  TCAReadme
//
//  Created by 문철현 on 2023/08/23.
//

import SwiftUI
import ComposableArchitecture

struct FeatureView: View {
    let store: StoreOf<Feature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    Text("\(viewStore.count)")
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                }

                Button("Number fact") {
                    viewStore.send(.numberFactButtonTapped)
                }
            }
            .alert(
                item: viewStore.binding(
                  get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                  send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(
            store: Store(initialState: Feature.State()) {
                Feature()
            }
        )
    }
}
#endif
