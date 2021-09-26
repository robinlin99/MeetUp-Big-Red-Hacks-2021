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
        viewModel.currentUser?.email ?? "none"
    }
    var id: String {
        viewModel.currentUser?.uid ?? "none"
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(email)
                    .font(.largeTitle)
                Text("User: \(id)")
                    .font(.body)
            }
            Spacer()
            Button(action: { viewModel.signOut() }, label: {
                HStack {
                    Image(systemName: "xmark.circle")
                        .font(.title)
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
