//
//  amplify_testApp.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import SwiftUI
import Amplify
import AmplifyPlugins


@main
struct amplify_testApp: App {
    
    //whenever auth state changes the observed object will update
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                
            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)
                
            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)
                
            case .session(let user):
                SessionView(user: user)
                    .environmentObject(sessionManager)
            }
//            ContentView()
        }
    }
    
    func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            
            print("successful configuration")
        } catch {
            print("error")
        }
    }
}
