//
//  ActivityInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI
import Foundation

struct ActivityInfoView: View {
    var title: String
    var author: String
    var date: Date
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: geometry.size.width * 0.08,
                                   height: geometry.size.width * 0.08)
                        Text(author)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    Spacer().frame(height: geometry.size.height * 0.01)
                    HStack {
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .frame(width: geometry.size.width * 0.08,
                                   height: geometry.size.width * 0.08)
                        Text("\(date)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }.padding()
            }.navigationTitle(title)
        }
    }
}

struct ActivityInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityInfoView(
            title: "🍕 Pizza Night on North Campus",
            author: "Robin Lin",
            date: Date()).preferredColorScheme(.dark)
    }
}
