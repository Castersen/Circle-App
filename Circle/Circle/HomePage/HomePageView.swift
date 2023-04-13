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

// Wellness score
struct Score: View {
    var score: Int
    var body: some View {
        HStack {
            Group {
                VStack(alignment: .leading) {
                    Text("Wellness Score")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("This score is based on your health data, time spent on certain apps, and surveys")
                        .font(.footnote)
                }
                Text(score.formatted())
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(15)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(score < 50 ? .red : .green)
        .foregroundColor(.white)
        .cornerRadius(15)
        .shadow(color: .gray, radius: 10)
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
