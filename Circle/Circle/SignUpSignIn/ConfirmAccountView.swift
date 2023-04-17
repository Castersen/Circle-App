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
    @ObservedObject var confirmAccountModel = ConfirmAccountModel()

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
            TextField("CONFIRM CODE", text: $confirmAccountModel.code)
                .overlay(FieldOverlay(image: Image(systemName: "checkmark.circle")))
                .keyboardType(.numberPad)
                .foregroundColor(Color(red: 249/255, green: 135/255, blue: 3/255))
                .fontWeight(.bold)
            Text(confirmAccountModel.codePrompt)
                .font(.footnote)
                .foregroundColor(.red)
                .fontWeight(.bold)


            // Submit Button
            Button(action: {
                Task {
                    await confirmAccountModel.submitCode(sessionManager: self.sessionManager, username: self.username)
                }
            }, label: {
                Text("CONFIRM ACCOUNT")
            })
            .buttonStyle(ActionButtonStyle())
            Text(confirmAccountModel.errorPrompt)
                .font(.footnote)
                .foregroundColor(.red)
                .fontWeight(.bold)
        }
        .padding(20)
        .textFieldStyle(SignUpFieldStyle())
    }
}

struct ConfirmAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmAccountView(username: "Fake user")
    }
}
