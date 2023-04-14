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
    init() {
        configureAmplify()
    }

    var body: some Scene {
        WindowGroup {
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
