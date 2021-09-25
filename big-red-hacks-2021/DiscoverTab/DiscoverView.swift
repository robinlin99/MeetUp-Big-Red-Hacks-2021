//
//  DiscoverView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        GeometryReader { geometry in
            ProfileView()
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView().preferredColorScheme(.dark)
    }
}
