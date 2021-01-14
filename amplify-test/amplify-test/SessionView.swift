//
//  SessionView.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import SwiftUI
import Amplify

struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    let user: AuthUser
    
    @State var username: String = ""
    var body: some View {
        VStack{
        Text("you \(self.username) signed in successfully")
            
            Button(action: {
                sessionManager.signout()
            }){
                Text("Sign out")
            }
            
        }
        
        
    }
}

struct SessionView_Previews: PreviewProvider {
    struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    static var previews: some View {

        SessionView(user: DummyUser())
    }
}
