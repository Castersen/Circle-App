//
//  HomePageView.swift
//  Circle
//
//  Created by Jabet on 4/12/23.
//

import SwiftUI

struct HomePageView: View {

    var body: some View {
        NavigationStack {
            VStack {
                // Wellness Score
                Score(score: 5)

                // Manage circle members
                CircleMembers()

                // Manage apps
                ManageApps()

                // Take survey
                TakeSurvey()

                // Health view
                HealthData()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Score: View {
    var score: Int
    var body: some View {
        Text("This is the score")
    }
}

struct CircleMembers: View {
    var body: some View {
        Text("Manage circle members")
    }
}

struct ManageApps: View {
    var body: some View {
        Text("Manage your apps")
    }
}

struct TakeSurvey: View {
    var body: some View {
        Text("Take Survey")
    }
}

struct HealthData: View {
    var body: some View {
        Text("Health View")
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
