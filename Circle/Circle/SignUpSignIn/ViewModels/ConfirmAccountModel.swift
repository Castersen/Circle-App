//
//  ConfirmAccountModel.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/17/23.
//

import Foundation
import Amplify

class ConfirmAccountModel: ObservableObject {
    @Published var code: String = ""

    @Published var error: AuthError? = nil

    // MARK: - Validation Functions

    func isCodeValid() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "\\d{6}$")
        return passwordTest.evaluate(with: code)
    }

    var isCodeComplete: Bool {
        if !isCodeValid() {
            return false
        }
        return true
    }

    // MARK: - Validation Prompt Strings

    var codePrompt: String {
        if isCodeValid() {
            return ""
        } else {
            return "Please enter the 6 digit code"
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
    func submitCode(sessionManager: SessionManager, username: String) async {
        error = await sessionManager.confirmSignUp(for: username, with: code)
    }
}
