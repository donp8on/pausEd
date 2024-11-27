//
//  AuthViewModel.swift
//  pausEd
//
//  Created by Don Payton on 10/30/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email
    }
}

class AuthViewModel: ObservableObject {
    @Published var currentUser: FirebaseAuth.User? // Use FirebaseAuth.User explicitly
    @Published var isAuthenticated: Bool = Auth.auth().currentUser != nil
    
    static let shared = AuthViewModel()
    
    private init() {}
    

    func signIn(withEmail email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        DispatchQueue.main.async {
            self.currentUser = authDataResult.user
        }
    }


    func createUser(withEmail email: String, password: String, fullname: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }

    func signOut() throws {
        try Auth.auth().signOut()
        isAuthenticated = false // Update the authentication state
    }

    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { return }
        try await user.delete()
        self.currentUser = nil
    }

    func fetchUser() async {
        if let user = Auth.auth().currentUser {
            self.currentUser = user
        }
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
}





