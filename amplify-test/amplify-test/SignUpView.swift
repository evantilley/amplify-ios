//
//  SignUpView().swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    var body: some View {
        VStack{
            Text("Sign up")
            TextField("Username", text: self.$username)
            TextField("Email", text: self.$email)
            TextField("Password", text: self.$password)
            
            
            Button(action: {
                sessionManager.signUp(username: username, email: email, password: password)
            }) {
                Text("Sign up")
            }
            
            Button(action: {
                sessionManager.showLogin()
            }){
                Text("Already have an account? Log in.")
            }
        }
    }
}

struct SignUpView___Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
