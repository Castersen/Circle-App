//
//  SignUpModel.swift
//  Circle
//
//  Created by Jabet on 4/17/23.
//

import Foundation
import Amplify

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPw: String = ""
    
    @Published var error: AuthError? = nil

    // MARK: - Validation Functions

    func passwordsMatch() -> Bool {
        password == confirmPw
    }

    func isPasswordValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[0-9])(?=.*[A-Z])(?=.*[!#$@%^&*()\"{}/[/]-=|';:<>]).{8,}$")
        return passwordTest.evaluate(with: password)
    }

    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }

    var isSignUpComplete: Bool {
        if !isPasswordValid() || !passwordsMatch()
            || !isEmailValid() {
            return false
        }
        return true
    }

    // MARK: - Validation Prompt Strings

    var confirmPwPrompt: String {
        if passwordsMatch() {
            return ""
        } else {
            return "Password fields do not match"
        }
    }

    var emailPrompt: String {
        if isEmailValid() {
            return ""
        } else {
            return "Enter a valid email address"
        }
    }

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

    func signUp(sessionManager: SessionManager) async {
        error = await sessionManager.signUp(username: username, password: password, email: email)
    }
}
