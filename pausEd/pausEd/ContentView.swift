//
//  ContentView.swift
//  pausEd
//
//  Created by Don Payton on 10/24/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager() // Initialize TimerManager

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    homeView(timerManager: TimerManager())
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(1)

                    LessonsView(timerManager: TimerManager())
                        .tabItem {
                            Image(systemName: "book")
                            Text("Lessons")
                        }
                        .tag(2)

                    ExerciseView(timerManager: TimerManager())
                        .tabItem {
                            Image(systemName: "figure.walk")
                            Text("Exercise")
                        }
                        .tag(3)

                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Settings")
                        }
                        .tag(4)
                }
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("logo") // Replace with your logo image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: TimerView(timerManager: timerManager)) {
                            Image(systemName: "clock")
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline) // Set title display mode to inline

        }
    }
}

#Preview {
    ContentView()
}
