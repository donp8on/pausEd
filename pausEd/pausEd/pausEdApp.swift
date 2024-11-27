//
//  pausEdApp.swift
//  pausEd
//
//  Created by Don Payton on 10/24/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct PausEdApp: App {
    @StateObject private var authViewModel = AuthViewModel.shared // Singleton instance of AuthViewModel
    @StateObject private var timerManager = TimerManager() // Assuming TimerManager is an observable object

    // Ensure Firebase is configured when the app launches
    init() {
        FirebaseApp.configure() // Configure Firebase
    }

    var body: some Scene {
        WindowGroup {
            // Check if the user is authenticated and show the appropriate view
            if authViewModel.isAuthenticated {
                ContentView()
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("Firebase Configured!")
        
        return true
    }
}

