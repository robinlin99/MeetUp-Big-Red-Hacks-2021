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
    var name: String
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
    var activities: [Activity] {
        [testActivity1,
         testActivity2,
         testActivity3]
    }
    @State var searchText: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            GeometryReader { geometry in
                VStack() {
                    ZStack {
                        if (colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color(red: 50 / 255,
                                            green: 50 / 255,
                                            blue: 50 / 255))
                                .frame(width: geometry.size.width * 0.90,
                                       height: geometry.size.width * 0.20)
                        } else {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color(red: 255 / 255,
                                            green: 255 / 255,
                                            blue: 255 / 255))
                                .frame(width: geometry.size.width * 0.90,
                                       height: geometry.size.width * 0.20)
                        }
                        HStack() {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: geometry.size.width * 0.15,
                                       height: geometry.size.width * 0.15)
                                .clipShape(Circle())
                                .overlay(Circle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(Color.white))
                            Spacer()
                                .frame(width: geometry.size.width * 0.05)
                            VStack(alignment: .leading) {
                                Text(name)
                                    .font(.system(size: 25.0))
                                Button(action: { print(viewModel.isSignedIn) }, label: {
                                    Text("View Profile")
                                })
                            }
                            Spacer()
                                .frame(width: geometry.size.width * 0.3)
                        }
                    }
                    .frame(width: geometry.size.width,
                           height: geometry.size.width * 0.20)
                    Spacer()
                        .frame(height: 0.05 * geometry.size.height)
                    SearchBarView(text: $searchText)
                    List(activities.filter({
                            searchText.isEmpty
                                ? true
                                : $0.title.contains(searchText)
                    })) { activity in
                        VStack(alignment: .leading) {
                            Text(activity.title)
                            Text("Poster: \(activity.author)")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            Text("Date: \(activity.date)")
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(name: "Peter Parker").preferredColorScheme(.dark)
    }
}
