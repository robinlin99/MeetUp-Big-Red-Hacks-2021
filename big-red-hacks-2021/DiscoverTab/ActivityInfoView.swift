//
//  ActivityInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI
import Foundation
import MapKit

struct ActivityInfoView: View {
    var title: String
    var author: String
    var date: Date
    @State var location: MKCoordinateRegion
    var description: String

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    VStack {
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
                        VStack (alignment: .leading) {
                            Text("Meetup Description")
                                .font(.title3)
                                .fontWeight(.heavy)
                            Text(description)
                                .font(.body)
                                .fontWeight(.light)
                        }
                        VStack (alignment: .center) {
                            Text("Meetup Location")
                                .font(.title3)
                                .fontWeight(.heavy)
                            Map(coordinateRegion: $location,
                                showsUserLocation: true,
                                userTrackingMode: .constant(.follow))
                                .frame(width: geometry.size.width * 0.90, height: geometry.size.width * 0.90)
                                .cornerRadius(15)
                        }.padding()
                    }
                }.navigationTitle(title)
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Register")
                            .fontWeight(.semibold)
                            .font(.headline)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                })
            }
        }
    }
}
