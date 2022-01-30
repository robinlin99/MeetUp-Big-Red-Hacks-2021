//
//  MeetsInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI

struct MeetsInfoView: View {
    @EnvironmentObject var viewModel: ViewModel
    var activities: [Activity] {
        viewModel.activities
    }
    var registeredActivities: [Activity] {
        viewModel.registeredActivities
    }
    
    var body: some View {
        NavigationView {
            List(registeredActivities) { activity in
                EventRowView(activity: activity)
            }
            .refreshable {
                viewModel.loadRegisteredActivities()
            }
            .navigationTitle("My Meets")
        }
    }
}

struct MeetsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MeetsInfoView()
    }
}
