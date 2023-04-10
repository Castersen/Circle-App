//
//  SignInView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/10/23.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Title
                Text("Login")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()

                // Input fields
                TextField("EMAIL", text: $email)
                    .overlay(FieldOverlay(image: Image(systemName: "envelope")))
                SecureField("PASSWORD", text: $password)
                    .overlay(FieldOverlay(image: Image(systemName: "lock")))

                // Submit Button
                Button("LOGIN") {
                    SignInHandler(Email: email, Password: password)
                }

                Text("Don't have an account? Sign Up")
            }
            .padding(20)
            .buttonStyle(ActionButtonStyle())
            .textFieldStyle(SignUpFieldStyle())
        }
    }
}

func SignInHandler(Email: String, Password: String) -> Void {
    return
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
