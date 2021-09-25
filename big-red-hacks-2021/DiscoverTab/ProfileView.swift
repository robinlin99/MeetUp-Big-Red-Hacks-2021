//
//  ProfileView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI

struct ProfileView: View {
    var name: String = "Peter Parker"
    var body: some View {
        GeometryReader { geometry in
            HStack() {
                Circle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * 0.2,
                           height: geometry.size.width * 0.2)
                Spacer()
                    .frame(width: geometry.size.width * 0.05)
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 25.0))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Button(action: {}) {
                        Text("View profile")
                        .font(.system(size: 15.0))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
