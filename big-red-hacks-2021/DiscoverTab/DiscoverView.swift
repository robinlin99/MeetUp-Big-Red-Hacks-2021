//
//  DiscoverView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI
import Foundation

struct DiscoverView: View {
    @EnvironmentObject var viewModel: ViewModel
    var email: String {
        viewModel.currentUser?.email ?? "none"
    }
    var id: String {
        viewModel.currentUser?.uid ?? "none"
    }
    var testActivity1: Activity =
        Activity(
            title: "🍿 Watch Spiderman Homecoming",
            author: "Mary Jane Watson", date: Date())
    var testActivity2: Activity =
        Activity(
            title: "⚽️ Outdoor Soccer on North Campus",
            author: "Ezra Cornell", date: Date())
    var testActivity3: Activity =
        Activity(
            title: "🍕 Pizza Night",
            author: "Uncle Sam", date: Date())
    var testActivity4: Activity =
        Activity(
            title: "⛳️ Mini Golf",
            author: "Tiger Woods", date: Date())
    var testActivity5: Activity =
        Activity(
            title: "📚 CS 6670 Computer Vision Study Session",
            author: "John Appleseed", date: Date())
    var activities: [Activity] {
        [testActivity1,
         testActivity2,
         testActivity3,
         testActivity4,
         testActivity5,
         testActivity1,
         testActivity2,
         testActivity3,
         testActivity4,
         testActivity5,
         testActivity1,
         testActivity2,
         testActivity3,
         testActivity4,
         testActivity5]
    }
    @State var searchText: String = ""
    @Environment(\.colorScheme) var colorScheme
    
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
                            title: activity.title, author: activity.author, date: activity.date)) {
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
