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
        viewModel.currentUser?.email ?? "none"
    }
    var id: String {
        viewModel.currentUser?.uid ?? "none"
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
                        NavigationLink(destination: ActivityInfoView(
                            title: activity.title,
                            author: activity.author,
                            date: activity.date,
                            location: MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: activity.meetupLocation.0,
                                    longitude: activity.meetupLocation.1),
                                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)),
                            description: activity.description)
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
                    .navigationBarTitle("Meets")
                }
            }
        }
    }
}
