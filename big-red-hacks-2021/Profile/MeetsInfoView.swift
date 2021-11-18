//
//  MeetsInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI

struct MeetsInfoView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            Text("My Meets")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

struct MeetsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MeetsInfoView()
    }
}
