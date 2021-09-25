//
//  ContentView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiscoverView(name: "Peter Parker")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            PostView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Post")
                }
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
