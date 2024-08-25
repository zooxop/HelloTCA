//
//  ContactsView.swift
//  ContactsApp
//
//  Created by 문철현 on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
  @Perception.Bindable
  var store: StoreOf<ContactsFeature>
  
  var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        List {
          ForEach(store.contacts) { contact in
            NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
              HStack {
                Text(contact.name)
                Spacer()
                Button {
                  store.send(.deleteButtonTapped(id: contact.id))
                } label: {
                  Image(systemName: "trash")
                    .foregroundStyle(.red)
                }
              }
            }
            .buttonStyle(.borderless)
          }
        }
        .navigationTitle("Contacts")
        .toolbar {
          ToolbarItem {
            Button {
              store.send(.addButtonTapped)
            } label: {
              Image(systemName: "plus")
            }
          }
        }
      } destination: { store in
        ContactDetailView(store: store)
      }
      .sheet(
        item: $store.scope(state: \.destination?.addContact, action: \.destination.addContact)
      ) { addContactStore in
        NavigationStack {
          AddContactView(store: addContactStore)
        }
      }
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
  }
}

#Preview {
  ContactsView(
    store: Store(
      initialState: ContactsFeature.State(
        contacts: [
          Contact(id: UUID(), name: "Blob"),
          Contact(id: UUID(), name: "Blob Jr"),
          Contact(id: UUID(), name: "Blob Sr"),
        ]
      )
    ) {
      ContactsFeature()
    }
  )
}
