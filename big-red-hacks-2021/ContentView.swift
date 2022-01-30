//
//  ContentView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var appStateModel: AppStateModel

    var body: some View {
        if !viewModel.isSignedIn {
            SignInView()
        } else {
            TabView(selection: $appStateModel.currentTab) {
                DiscoverView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Discover")
                    }.tag(Tab.discover)
                    .onAppear(perform: {
                        viewModel.loadActivities()
                        viewModel.loadUserProfile()
                    })
                PostView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Post")
                    }.tag(Tab.post)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Profile")
                    }.tag(Tab.profile)
                    .onAppear(perform: {
                        viewModel.loadSupportInfo()
                        viewModel.loadRegisteredActivities()
                        viewModel.loadPostedActivities()
                    })
            }
            .font(.headline)
        }
    }
}
