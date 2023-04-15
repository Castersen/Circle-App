//
//  CircleApp.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/5/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct CircleApp: App {

    @ObservedObject var sessionManager = SessionManager()

    init() {
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .loading:
                LoadingView()
                    .environmentObject(sessionManager)

            case .login:
                SignInView()
                    .environmentObject(sessionManager)

            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)

            case .home(let user):
                HomePageView(user: user)
                    .environmentObject(sessionManager)

            case .confirmCode(let username):
                ConfirmAccountView(username: username)
                    .environmentObject(sessionManager)
            }
        }
    }

    private func configureAmplify() {
            do {
                try Amplify.add(plugin: AWSCognitoAuthPlugin())
                try Amplify.configure()
                print("Amplify configured with auth plugin")
            } catch {
                print("Failed to initialize Amplify with \(error)")
            }
        }
}
