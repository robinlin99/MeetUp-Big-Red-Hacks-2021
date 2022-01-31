//
//  PostsView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI

struct PostsView: View {
    @EnvironmentObject var viewModel: ViewModel
    var activities: [Activity] {
        viewModel.activities
    }

    var postedActivities: [Activity] {
        viewModel.postedActivities
    }

    var body: some View {
        NavigationView {
            List(postedActivities) { activity in
                EventRowView(activity: activity)
            }
            .refreshable {
                viewModel.loadPostedActivities()
            }
            .navigationTitle("My Posts")
        }
    }
}
