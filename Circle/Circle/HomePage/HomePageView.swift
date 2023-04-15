//
//  HomePageView.swift
//  Circle
//
//  Created by Jabet on 4/12/23.
//

import SwiftUI
import Amplify

struct HomePageView: View {

    let user: AuthUser
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {

                    // Header
                    HStack(alignment: .bottom) {
                        Text("Welcome,")
                            .fontWeight(.bold)
                            .font(.title)
                        Text(user.username)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .padding(10)

                    Group {
                        // Wellness Score
                        Score(score: 50)
                        // Manage circle members
                        CircleMembers()
                        // Take survey
                        TakeSurvey()
                        // Manage apps
                        ManageApps()
                        // Sign out
                        SignOut(sessionManager: sessionManager)
                    }
                    .padding(10)
                }
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

// App tracker container
struct ManageApps: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Group {
                Text("App Tracker")
                    .padding([.top], 15)
                    .foregroundColor(Color(hue: 0.821, saturation: 0.046, brightness: 0.146))
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Time spent per week, tap to manage apps")
                    .font(.footnote)
                    .foregroundColor(Color(hue: 0.821, saturation: 0.046, brightness: 0.146))
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding([.leading], 15)

            // Watch apps
            AppSection(hours: 20, appType: "Watch", icon: "eyes", backgroundColor: Color.orange)

            // Focus apps
            AppSection(hours: 20, appType: "Focus", icon: "eyeglasses", backgroundColor: Color.green)

            // Self love apps
            AppSection(hours: 20, appType: "Self Love", icon: "heart", backgroundColor: Color.red)
                .padding([.bottom], 15)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(red: 0.96, green: 0.97, blue: 0.98))
        .cornerRadius(15)
        .shadow(color: .gray, radius: 5)
    }
}

// App tracker section
struct AppSection: View {
    var hours: Int
    var appType: String
    var icon: String
    var backgroundColor: Color

    var body: some View {
        Button {

        } label: {
            HStack {
                // Text data
                VStack(alignment: .leading) {
                    Text(appType + " Apps")
                        .fontWeight(.bold)
                        .font(.title3)
                    Text(hours.formatted() + " Hours")
                        .foregroundColor(.gray)
                }
                .padding(10)

                Spacer()

                // Icon
                Image(systemName: icon)
                    .frame(width: 60, height: 50)
                    .fontWeight(.bold)
                    .font(.title2)
                    .background(backgroundColor)
                    .cornerRadius(10)
                    .padding(10)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(5)
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 15)
            .shadow(color: .gray, radius: 5)
        }
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

struct SignOut: View {

    var sessionManager: SessionManager
    var body: some View {
        Button {
            Task {
                await sessionManager.signOutLocally()
            }
        } label: {
            HStack {
                Text("Sign Out")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title)
                    .fontWeight(.bold)
                }
            .padding(15)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 10)
            }
        }
}


struct HomePageView_Previews: PreviewProvider {
    struct FakeUser : AuthUser {
        var userId: String = "TEMP"
        let username: String = "User"
    }
    
    static var previews: some View {
        HomePageView(user: FakeUser())
    }
}
