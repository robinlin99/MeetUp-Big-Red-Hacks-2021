//
//  ProfileView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ViewModel
    var email: String {
        viewModel.currentUserProfile?.email ?? "none"
    }
    var name: String {
        viewModel.currentUserProfile?.name ?? "none"
    }
    
    var body: some View {
            GeometryReader { geometry in
                NavigationView {
                    VStack {
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                            VStack(alignment: .leading) {
                                Text(name)
                                    .font(.title)
                                    .bold()
                                Text(email)
                                    .font(.subheadline)
                                    .bold()
                            }
                            Spacer()
                        }
                        List {
                            NavigationLink("My Profile Information", destination: ProfileInfoView())
                            NavigationLink("Meets", destination: MeetsInfoView())
                            NavigationLink("My Posts", destination: PostsView())
                            NavigationLink("Help & Support", destination: LegalView())
                        }
                        .navigationTitle("My Profile")
                        Spacer()
                        Button(action: { viewModel.signOut() }, label: {
                            HStack {
                                Image(systemName: "xmark.circle")
                                Text("Sign Out")
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(30)
                        })
                    }.padding()
            }
        }
    }
}
