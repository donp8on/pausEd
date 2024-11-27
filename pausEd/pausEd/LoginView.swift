//
//  LoginView.swift
//  pausEd
//
//  Created by Don Payton on 10/24/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false // Track login status
    let timerManager = TimerManager() // Create an instance of TimerManager
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                homeView(timerManager: timerManager) // Pass the instance
            } else {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(.vertical, 32)
                    
                    VStack(spacing: 24) {
                        inputView(text: $email, title: "Email Address", placeholder: "example@paused.com")
                            .autocapitalization(.none)
                        
                        inputView(text: $password, title: "Password", placeholder: "Password", isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Forgot password tapped...")
                        }) {
                            Text("Forgot Password?")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding(.vertical, 10)
                        }
                        .padding(.trailing, 24.0)
                    }
                    
                    Button {
                        Task {
                            do {
                                try await AuthViewModel.shared.signIn(withEmail: email, password: password)
                                print("User logged in successfully!")
                                isLoggedIn = true // Update login status
                            } catch {
                                print("Failed to log in: \(error.localizedDescription)")
                            }
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(30)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignupView()
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    }
                    .background(Color(.lightGray).opacity(0.5))
                    .cornerRadius(30)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
