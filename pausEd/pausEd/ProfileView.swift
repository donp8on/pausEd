//
//  ProfileView.swift
//  pausEd
//
//  Created by Don Payton on 10/29/24.
//

import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    func signOut() throws {
        try AuthViewModel.shared.signOut()
    }
}


struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.title)
                    .padding(.leading, 25)
                Spacer()
            }

            List {
                Section {
                    HStack {
                        Text(User.MOCK_USER.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(User.MOCK_USER.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(User.MOCK_USER.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Section("Account") {
                    // Sign out button
                    Button {
                        Task {
                            do {
                                try authViewModel.signOut()
                            } catch {
                                print("Failed to sign out: \(error.localizedDescription)")
                            }
                        }
                    } label: {
                        SettingRowView(imageName: "arrow.left.circle", title: "Sign out", tintColor: .red)
                    }

                    // Erase Account
                    Button {
                        print("Erase Account...")
                    } label: {
                        SettingRowView(imageName: "xmark.circle", title: "Erase Account", tintColor: .red)
                    }
                }
            }
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View{
        ProfileView()
    }
}
