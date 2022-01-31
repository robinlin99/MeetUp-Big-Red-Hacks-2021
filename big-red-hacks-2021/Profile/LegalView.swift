//
//  LegalView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI

struct LegalView: View {
    @EnvironmentObject var viewModel: ViewModel
    var termsAndConditions: String {
        viewModel.supportInfo
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Terms and Conditions")
                    .font(.title)
                    .fontWeight(.bold)
                Text(termsAndConditions)
                    .font(.body)
                    .padding()
            }
        }
        .refreshable {
            viewModel.loadSupportInfo()
        }
    }
}
