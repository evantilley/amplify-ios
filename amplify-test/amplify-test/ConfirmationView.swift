//
//  ConfirmationView.swift
//  amplify-test
//
//  Created by Evan Tilley on 1/12/21.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var username = ""
    
    @State var confirmationCode = ""
    
    var body: some View {
        Text("Confirming \(self.username)")
        TextField("confirm", text: self.$confirmationCode)
        Button(action: {
            sessionManager.confirm(username: username, code: confirmationCode)
        }){
            Text("Confirm")
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
