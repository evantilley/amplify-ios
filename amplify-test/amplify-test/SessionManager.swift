//
//  SessionManager.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import Foundation
import Amplify

enum AuthState{
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

final class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser() {
        //if person is already authenticated, go to
        //session
        if let user = Amplify.Auth.getCurrentUser(){
            authState = .session(user: user)
        } else {
            //otherwise, go to login state
            authState = .login
        }
    }
    
    func showSignUp() {
        authState = .signUp
    }
    func showLogin() {
        authState = .login
    }
    
    func signUp(username: String, email: String, password: String){
        //pass in the email as an attribute
        let attributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        _ = Amplify.Auth.signUp(username: username, password: password, options: options, listener: { [weak self] (result) in
            switch result {
            case .success(let signUpResult):
                print("sign up result", signUpResult)
                
                switch signUpResult.nextStep {
                case .done:
                    print("finished signing up")
                    
                case .confirmUser(let details, _):
                    print(details ?? "no details")
                    
                    //return to main thread
                    DispatchQueue.main.async {
                        self?.authState  = .confirmCode(username: username)
                    }
                    
                
                }
                
            case .failure(let error):
                print("sign up error", error)
                
            }
        })
        
        
    }
    
    func confirm(username: String, code: String){
        _ = Amplify.Auth.confirmSignUp(for: username, confirmationCode: code, listener: { [weak self] (result) in
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete{
                    DispatchQueue.main.async{
                        self?.showLogin()
                    }
                }
            
            case .failure(let error):
                print("failed to confirm code:", error)
            }
        })
    }
    
    func login(username: String, password: String){
        _ = Amplify.Auth.signIn(username: username, password: password, listener: { [weak self] (result) in
            switch result {
            case .success(let signInResult):
                print(signInResult)
                //if we are signed in
                if signInResult.isSignedIn {
                    //go to main thread
                    DispatchQueue.main.async{
                        //get current user and create a new session
                        self?.getCurrentAuthUser()
                    }
                }
                
            case .failure(let error):
                print("error", error)
            }
        })
    }
    
    func signout(){
        _ = Amplify.Auth.signOut(listener: { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async{
                    //will return nil which sets out state to login
                    self?.getCurrentAuthUser()
                }
            case .failure(let error):
                print("error", error)
            }
        })
    }
    
}
