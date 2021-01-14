//
//  LoginView.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack{
            Text("Login")
            TextField("username", text: self.$username)
            TextField("password", text: self.$password)
            
            Button(action: {
                sessionManager.login(username: self.username, password: self.password)
            }){
                Text("Login")
            }
            
            Button(action: {
                sessionManager.signout()
            }){
                Text("Logout")
            }
            
            Button(action: {
                sessionManager.showSignUp()
            }){
                Text("Don't have an account? Sign up.")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
