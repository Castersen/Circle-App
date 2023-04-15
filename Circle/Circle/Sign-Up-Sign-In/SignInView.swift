//
//  SignInView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/10/23.
//

import SwiftUI

struct SignInView: View {

    @EnvironmentObject var sessionManager: SessionManager

    @State var email: String = ""
    @State var password: String = ""
    @State var logInPass: Bool = false
    
    // Used to pop off the stack and return to the previous view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Title
                Text("Login")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()

                // Input fields
                TextField("EMAIL/USERNAME", text: $email)
                    .overlay(FieldOverlay(image: Image(systemName: "envelope")))
                SecureField("PASSWORD", text: $password)
                    .overlay(FieldOverlay(image: Image(systemName: "lock")))

                // Submit Button
                Button("LOGIN") {
                    Task {
                        await SignInHandler(username: email, Password: password, sessionManager: sessionManager)
                    }
                }
                .buttonStyle(ActionButtonStyle())

                HStack {
                    Text("Don't have an account?")
                    Button("Sign Up") {
                        dismiss()
                    }
                    .foregroundColor(Color(red: 249/255, green: 135/255, blue: 3/255))
                }
            }
            .padding(20)
            .textFieldStyle(SignUpFieldStyle())
        }
    }
}

func SignInHandler(username: String, Password: String,
                   sessionManager: SessionManager) async -> Void {
    if username.isEmpty || Password.isEmpty {
        return
    }
    await sessionManager.signIn(username: username, password: Password)
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
