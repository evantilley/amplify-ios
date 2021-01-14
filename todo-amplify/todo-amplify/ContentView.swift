//
//  ContentView.swift
//  todo-amplify
//
//  Created by Evan Tilley on 1/13/21.
//

import Amplify
import Combine
import SwiftUI

struct ContentView: View {
    @State var todos = [Todo]()
    
    @State var showNewTodo = false
    
    @State var observationToken: AnyCancellable?
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(todos){todo in
                        Text(todo.body)
                        
                    }
                    .onDelete(perform: deleteTodo)
                }
                VStack{
                    Spacer()
                Button(action: {
                    showNewTodo.toggle()
                }){
                    Image(systemName: "plus")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                    
                }
                    Spacer()
                        .frame(height: 30)
                }
            }.navigationTitle("Todo")
            .sheet(isPresented: $showNewTodo){
                NewTodoView()
            }
        }
        .onAppear{
            getTodos()
            observeTodos()
        }
    }
    
    func getTodos(){
        Amplify.DataStore.query(Todo.self) { (result) in
            switch result {
            case .success(let todos):
                print(todos)
                self.todos = todos
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //like a snapshot listener
    func observeTodos() {
        observationToken = Amplify.DataStore.publisher(for: Todo.self).sink { (completion) in
            //check if there is an error when the data store is updated
            if case .failure(let error) = completion {
                print(error)
            }
        } receiveValue: { (changes) in
            
            guard let todo = try? changes.decodeModel(as: Todo.self) else {return}
            
            switch changes.mutationType {
            case "create":
                self.todos.append(todo)
                
            case "delete":
                if let index = self.todos.firstIndex(of: todo){
                    self.todos.remove(at: index)
                }
                break
                
            default:
                break
            }
        }

    }
    
    func deleteTodo(indexSet: IndexSet){
        print("deleted item at \(indexSet)")
        
        //create a copy of updatedTodos array
        var updatedTodos = todos
        //remove the removed index from copy
        updatedTodos.remove(atOffsets: indexSet)
        
        //take the difference between the two arrays, which is just the
        //one todo we removed
        guard let todo = Set(updatedTodos).symmetricDifference(todos).first else {
            return
        }
        
        Amplify.DataStore.delete(todo){result in
            switch result {
            //since observing don't need to do anything with callback todo
            case .success(let todo):
                print("deleted todo")
                
            case .failure(let error):
                print("error \(error)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
