//
//  SessionManager.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/13/23.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin

enum AuthState {
    case loading
    case signUp
    case login
    case confirmCode(username: String)
    case home(user: AuthUser)
}

final class SessionManager : ObservableObject {
    @Published var authState: AuthState = .loading

    func fetchCurrentAuthSession() async {
        do {
            // Get current session information
            let session = try await Amplify.Auth.fetchAuthSession()

            // Set the session state
            if session.isSignedIn {
                let user = try await Amplify.Auth.getCurrentUser()
                DispatchQueue.main.async { [weak self] in
                    self?.authState = .home(user: user)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.authState = .signUp
                }
            }

        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }

}
