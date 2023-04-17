//
//  SignInModel.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/17/23.
//

import Foundation
import Amplify

class SignInViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""

    @Published var error: AuthError? = nil

    // MARK: - Validation Functions

    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[0-9])(?=.*[A-Z])(?=.*[!#$@%^&*()\"{}/[/]-=|';:<>]).{8,}$")
        return passwordTest.evaluate(with: password)
    }

    var isSignUpComplete: Bool {
        if !isPasswordValid() {
            return false
        }
        return true
    }

    // MARK: - Validation Prompt Strings

    var passwordPrompt: String {
        if isPasswordValid() {
            return ""
        } else {
            return "Must be at least 8 characters containing at least one number, one capital letter, and one special character"
        }
    }

    var errorPrompt: String {
        if error == nil {
            return ""
        } else {
            return "\(String(describing: error))"
        }
    }

    @MainActor
    func signIn(sessionManager: SessionManager) async {
        error = await sessionManager.signIn(username: username, password: password)
    }
}
