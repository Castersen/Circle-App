//
//  LoadingView.swift
//  Circle
//
//  Created by Jonathan Castersen on 4/14/23.
//

import SwiftUI

struct LoadingView: View {

    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Text("Loading...")
        .task {
            await sessionManager.fetchCurrentAuthSession()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
