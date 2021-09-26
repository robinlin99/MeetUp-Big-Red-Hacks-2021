//
//  ContentView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "backgroundColor")
    }
    
    var body: some View {
        if !viewModel.isSignedIn {
            SignInView()
        } else {
            TabView {
                DiscoverView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Discover")
                    }
                PostView()
                    .tabItem {
                        Image(systemName: "plus.circle")
                        Text("Post")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Profile")
                    }
            }
            .font(.headline)
        }
    }
}
