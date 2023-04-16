//
//  ConfirmAccountView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/13/23.
//

import SwiftUI

struct ConfirmAccountView: View {

    let username: String

    @EnvironmentObject var sessionManager: SessionManager
    @State var confirmCode: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(username)
                .font(.title3)
                .foregroundColor(.gray)
            // Title
            Text("Confirm Account")
                .font(.title)
                .foregroundColor(.black)
                .bold()

            // Input fields
            TextField("CONFIRM CODE", text: $confirmCode)
                .overlay(FieldOverlay(image: Image(systemName: "checkmark.circle")))
                .keyboardType(.numberPad)
                .foregroundColor(Color(red: 249/255, green: 135/255, blue: 3/255))
                .fontWeight(.bold)

            // Submit Button
            Button(action: {
                Task {
                    await confirmCodeHandler(confirmationCode: confirmCode, username: username, sessionManager: sessionManager)
                }
            }, label: {
                Text("CONFIRM ACCOUNT")
            })
            .buttonStyle(ActionButtonStyle())
        }
        .padding(20)
        .textFieldStyle(SignUpFieldStyle())
    }
}

func confirmCodeHandler(confirmationCode: String, username: String, sessionManager: SessionManager) async -> Void {
    await sessionManager.confirmSignUp(for: username, with: confirmationCode)
}

struct ConfirmAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAccountView(username: "Fake user")
    }
}
