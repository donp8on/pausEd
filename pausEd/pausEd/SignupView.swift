//
//  SignupView.swift
//  pausEd
//
//  Created by Don Payton on 10/24/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            // image
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .padding(.vertical, 32)
            
            // form fields
            VStack(spacing: 24) {
                inputView(text: $fullname, title: "Full Name", placeholder: "Enter your name")
                    .autocapitalization(.none)
                
                inputView(text: $email, title: "Email Address", placeholder: "example@paused.com")
                    .autocapitalization(.none)
                
                inputView(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                
                inputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your password", isSecureField: true)
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign up button
            Button {
                print("Sign user up...")
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(30)
            .padding(.top, 24)
            
            Spacer()
            
            // sign in button
            Text("Already have an account?")
                .font(.subheadline)
            
            NavigationLink {
                LoginView()
            } label: {
                HStack {
                    Text("SIGN IN")
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
