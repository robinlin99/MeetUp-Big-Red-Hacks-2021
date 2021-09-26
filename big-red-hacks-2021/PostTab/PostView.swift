//
//  PostView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        Text("Post A Meetup")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView().preferredColorScheme(.dark)
    }
}
