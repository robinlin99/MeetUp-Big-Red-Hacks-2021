//
//  DiscoverView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI
import Foundation
import MapKit

struct DiscoverView: View {
    @EnvironmentObject var viewModel: ViewModel
    var email: String {
        viewModel.currentAuthUser?.email ?? "none"
    }
    var id: String {
        viewModel.currentAuthUser?.uid ?? "none"
    }
    var activities: [Activity] {
        viewModel.activities
    }
    @State var searchText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    SearchBarView(text: $searchText)
                    List(activities.filter({
                            searchText.isEmpty
                                ? true
                        : $0.title.lowercased().contains(searchText.lowercased())
                    })) { activity in
                        NavigationLink(
                            destination: ActivityInfoView(activity: activity)
                        ) {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                Text("Poster: \(activity.author)")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text("Date: \(activity.date)")
                            }
                        }
                    }
                    .refreshable {
                        viewModel.loadActivities()
                    }
                    .navigationBarTitle("Meets")
                }
            }.onAppear(perform: {
                viewModel.loadActivities()
                viewModel.loadUserProfile()
            })
        }
    }
}
