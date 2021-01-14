//
//  ContentView.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import Amplify
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var authStatus: String?
    var body: some View {

        VStack {
            if let authStatus = self.authStatus {
                Text(authStatus)
                    .padding()
            }
            Button("Get status", action: {
                checkAuthStatus()
            })
                .padding()
        }
    }
    
    func checkAuthStatus() {
        Amplify.Auth.fetchAuthSession { (result) in
            switch result {
            
            //no error
            case .success(let authSession):
                //prints either true or false
                print("the current user is signed in: \(authSession.isSignedIn) ")
                self.authStatus = String(authSession.isSignedIn)
                
            //error
            case .failure(let authError):
                print("failed to fetch the auth sesion", authError)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
