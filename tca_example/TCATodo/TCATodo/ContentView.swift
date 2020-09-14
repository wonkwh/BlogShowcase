//
//  ContentView.swift
//  TCATodo
//
//  Created by wonkwh on 2020/07/11.
//  Copyright © 2020 wonkwh. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ToDo: Equatable, Identifiable {
    var description = ""
    let id: UUID
    var isComplete = false
}

struct AppState: Equatable {
    var todos: [ToDo]
}

enum AppAction {
    case todoCheckboxTapped(index: Int)
    case todoTextFieldChanged(index: Int, text: String)
}

struct AppEnvironment {
    
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    switch action {
        
    case .todoCheckboxTapped(index: let index):
        state.todos[index].isComplete.toggle()
        return .none
    case .todoTextFieldChanged(index: let index, text: let text):
        state.todos[index].description = text
        return .none
    }
}

struct ContentView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                List {
                    ForEach(Array(viewStore.todos.enumerated()), id: \.element.id) { index, todo in
                        HStack {
                            Button(action: {
                                viewStore.send(.todoCheckboxTapped(index: index))
                            }) {
                                Image(systemName: todo.isComplete ? "checkmark.square": "square")
                            }.buttonStyle(PlainButtonStyle())
                            
                            TextField("Untitled todo", text: viewStore.binding(
                              get: { $0.todos[index].description },
                              send: { .todoTextFieldChanged(index: index, text: $0) }
                            ))
                        }.foregroundColor(todo.isComplete ? .gray : nil)
                    }
                }.navigationBarTitle("Todos")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(todos: [
                    ToDo(description: "PointFree", id: UUID(), isComplete: true),
                    ToDo(description: "Udemy", id: UUID(), isComplete: false),
                    ToDo(description: "MoimApp", id: UUID(), isComplete: false),
                ]),
                reducer: appReducer.debug(),
                environment: AppEnvironment()
            )
        )
    }
}
