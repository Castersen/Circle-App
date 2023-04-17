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

    // Sign up call
    func signUp(username: String, password: String, email: String) async -> AuthError? {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                DispatchQueue.main.async { [weak self] in
                    self?.authState = .confirmCode(username: username)
                }
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
            } else {
                print("SignUp Complete")
                DispatchQueue.main.async { [weak self] in
                    self?.authState = .confirmCode(username: username)
                }
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
            return error
        } catch {
            print("Unexpected error: \(error)")
        }
        
        return nil
    }

    // Sign in call
    func signIn(username: String, password: String) async -> AuthError? {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
            if signInResult.isSignedIn {
                print("Sign in succeeded")
                DispatchQueue.main.async { Task { [weak self] in
                    await self?.fetchCurrentAuthSession()
                } }
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
            return error
        } catch {
            print("Unexpected error: \(error)")
        }

        return nil
    }

    // Confirmation sign up call
    func confirmSignUp(for username: String, with confirmationCode: String) async -> AuthError? {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
            DispatchQueue.main.async { [weak self] in
                self?.authState = .login
            }
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
            return error
        } catch {
            print("Unexpected error: \(error)")
        }

        return nil
    }

    // Local sign out
    func signOutLocally() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            return
        }

        print("Local signout successful: \(signOutResult.signedOutLocally)")
        switch signOutResult {
        case .complete:
            DispatchQueue.main.async { [weak self] in
                self?.authState = .signUp
            }

        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.

            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }

            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }

            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }
}
