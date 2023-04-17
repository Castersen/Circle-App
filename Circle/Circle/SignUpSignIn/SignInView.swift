//
//  SignInView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/10/23.
//

import SwiftUI

struct SignInView: View {

    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var signInVM = SignInViewModel()
    
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
                TextField("EMAIL/USERNAME", text: $signInVM.username)
                    .textInputAutocapitalization(.none)
                    .overlay(FieldOverlay(image: Image(systemName: "envelope")))

                SecureField("PASSWORD", text: $signInVM.password)
                    .textInputAutocapitalization(.none)
                    .overlay(FieldOverlay(image: Image(systemName: "lock")))
                Text(signInVM.passwordPrompt)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .fontWeight(.bold)

                // Submit Button
                Button("LOGIN") {
                    Task {
                        await signInVM.signIn(sessionManager: self.sessionManager)
                    }
                }
                .buttonStyle(ActionButtonStyle())
                .opacity(signInVM.isSignUpComplete ? 1 : 0.8)
                .disabled(!signInVM.isSignUpComplete)

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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
