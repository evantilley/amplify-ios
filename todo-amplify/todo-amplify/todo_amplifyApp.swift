//
//  todo_amplifyApp.swift
//  todo-amplify
//
//  Created by Evan Tilley on 1/13/21.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct todo_amplifyApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureAmplify(){
        do {
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            
            try Amplify.configure()
            print("Amplify initialized")
        } catch {
            print("Could not initialize amplify - \(error)")
        }
    }
}
