//
//  NewTodoView.swift
//  todo-amplify
//
//  Created by Evan Tilley on 1/13/21.
//

import SwiftUI
import Amplify

struct NewTodoView: View {
    @State var text = String()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            Text("Enter a new todo")
                .font(.largeTitle)
            
            TextEditor(text: $text)
                .padding(.horizontal)
            
            Button(action: {
                self.saveTodo()
            }){
                Text("Save")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                
            }
            Spacer()
                .frame(height: 30)
        }
    }
    func saveTodo(){
        print(text)
        
        let todo = Todo(body: text)
        
        Amplify.DataStore.save(todo){result in
            switch result {
            case .success(let todo):
                //no need to use the todo callback here
                print("saved todo")
                
            case .failure(let error):
                print(error)
            }
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView()
    }
}
