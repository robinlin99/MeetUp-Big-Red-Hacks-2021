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
            Text(email)
            Text(id)
            Button(action: { viewModel.signOut() }, label: {
                Text("Sign Out")
                    .foregroundColor(Color.red)
            })
        }
    }
}
