//
//  SignUpView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/5/23.
//

import SwiftUI

struct SignUpView: View {
 
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var signUpVM = SignUpViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Title
                Text("Create Account")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()

                // Input fields
                TextField("USERNAME", text: $signUpVM.username)
                    .overlay(FieldOverlay(image: Image(systemName: "person")))

                TextField("EMAIL", text: $signUpVM.email)
                    .overlay(FieldOverlay(image: Image(systemName: "envelope")))
                Text(signUpVM.emailPrompt)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .fontWeight(.bold)

                SecureField("PASSWORD", text: $signUpVM.password)
                    .overlay(FieldOverlay(image: Image(systemName: "lock")))
                Text(signUpVM.passwordPrompt)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .fontWeight(.bold)

                SecureField("CONFIRM PASSWORD", text: $signUpVM.confirmPw)
                    .overlay(FieldOverlay(image: Image(systemName: "lock")))
                Text(signUpVM.confirmPwPrompt)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .fontWeight(.bold)

                // Submit Button
                Button(action: {
                    Task {
                        await signUpVM.signUp(sessionManager: self.sessionManager)
                    }
                }, label: {
                  Text("SIGN UP")
                })
                .buttonStyle(ActionButtonStyle())
                .opacity(signUpVM.isSignUpComplete ? 1 : 0.8)
                .disabled(!signUpVM.isSignUpComplete)

                HStack {
                    Text("Already have an account?")
                    NavigationLink(destination: SignInView()) {
                        Text("Sign In")
                            .foregroundColor(Color(red: 249/255, green: 135/255, blue: 3/255))
                    }
                }
                
            }
            .padding(20)
            .textFieldStyle(SignUpFieldStyle())
        }
        .navigationBarBackButtonHidden()
    }
}

// Create account logic
func SignUpHandler(Email: String, Username: String,
                   Password: String, ConfirmPassword: String,
                   sessionManager: SessionManager) async -> Void {
    if Email.isEmpty || Username.isEmpty || Password.isEmpty || ConfirmPassword.isEmpty {
        return
    }
    if Password != ConfirmPassword {
        return
    }
    await sessionManager.signUp(username: Username, password: Password, email: Email)
}

// Field overlay
struct FieldOverlay : View {
    var image: Image

    var body: some View {
        image
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
}

// Field style
struct SignUpFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(10)
                .padding(.leading, 36)
        }
}

// Button style
struct ActionButtonStyle: ButtonStyle {
    static let color0 = Color(red: 248/255, green: 196/255, blue: 88/255)
    static let color1 = Color(red: 249/255, green: 135/255, blue: 3/255)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .fontWeight(.bold)
            .frame(maxWidth: Double.infinity)
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [ActionButtonStyle.color0, ActionButtonStyle.color1]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
                    .opacity(
                        configuration.isPressed ? 0.5 : 1
                    )
            )
            .cornerRadius(60)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
