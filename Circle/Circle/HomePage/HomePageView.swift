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

// Cicrle members
struct CircleMembers: View {
    var body: some View {
        Button {
            // Action here
        } label:
        {
            HStack {
                Group {
                    VStack(alignment: .leading) {
                        Text("Manage Circle Members")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Circle members are a way to help those close to you improve your well being")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                    }
                    Image(systemName: "circle")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                }
                .padding(15)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(red: 249/255, green: 135/255, blue: 3/255))
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 10)
        }
    }
}

struct ManageApps: View {
    var body: some View {
        Text("Manage your apps")
    }
}

// Survey Section
struct TakeSurvey: View {

    var body: some View {
        Button {
            // Action here
        } label: {
            HStack {
                Text("Take Survey")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "list.bullet.clipboard")
                    .font(.title)
                    .fontWeight(.bold)
                }
            .padding(15)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.cyan)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10)
            }
        }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
