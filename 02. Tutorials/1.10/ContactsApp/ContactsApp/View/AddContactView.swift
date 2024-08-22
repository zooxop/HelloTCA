//
//  AddContactView.swift
//  ContactsApp
//
//  Created by 문철현 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
  @Perception.Bindable
  var store: StoreOf<AddContactFeature>
  
  var body: some View {
    WithPerceptionTracking {
      Form {
        TextField("Name", text: $store.contact.name.sending(\.setName))
        Button("Save") {
          store.send(.saveButtonTapped)
        }
      }
      .toolbar {
        ToolbarItem {
          Button("Cancel") {
            store.send(.cancelButtonTapped)
          }
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    AddContactView(
      store: Store(
        initialState: AddContactFeature.State(
          contact: Contact(
            id: UUID(),
            name: "Blob"
          )
        )
      ) {
        AddContactFeature()
      }
    )
  }
}
