//
//  ActivityInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import SwiftUI
import Foundation

struct ActivityInfoView: View {
    var activity: Activity
    var title: String {
        activity.title
    }
    var author: String {
        activity.author
    }
    var date: String {
        activity.date
    }
    var meetupAddress: String {
        activity.address
    }
    var description: String {
        activity.description
    }
    var posterEmail: String {
        activity.posterEmail
    }
    var posterPhone: String {
        activity.posterPhoneNumber
    }
    var isVaccineRequired: Bool {
        activity.isVaccineRequired
    }
    var isTestingRequired: Bool {
        activity.isTestingRequired
    }
    var isMaskRequired: Bool {
        activity.isMaskRequired
    }
    var people: Int {
        activity.people
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView {
                    VStack {
                        VStack {
                            // Author.
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.08,
                                           height: geometry.size.width * 0.08)
                                Text(author)
                                    .fontWeight(.semibold)
                                Spacer()
                            }.padding(.leading)
                            Spacer().frame(height: geometry.size.height * 0.015)
                            // Email.
                            HStack {
                                Image(systemName: "envelope.open")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.08,
                                           height: geometry.size.width * 0.08)
                                Text(posterEmail)
                                    .font(.body)
                                Spacer()
                            }.padding(.leading)
                            Spacer().frame(height: geometry.size.height * 0.015)
                            // Phone.
                            HStack {
                                Image(systemName: "phone")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.08,
                                           height: geometry.size.width * 0.08)
                                Text(posterPhone)
                                    .font(.body)
                                Spacer()
                            }.padding(.leading)
                            Spacer().frame(height: geometry.size.height * 0.015)
                            // Meet Time.
                            HStack {
                                Image(systemName: "calendar.circle")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.08,
                                           height: geometry.size.width * 0.08)
                                Text(date)
                                    .font(.body)
                                Spacer()
                            }.padding(.leading)
                        }.padding()
                        // MARK: Description.
                        VStack {
                            HStack {
                                Text("Meetup details")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                Spacer()
                            }.padding()
                            Text(description)
                                .font(.body)
                                .fontWeight(.light)
                                .padding(.leading)
                        }.padding()
                        // MARK: Getting there.
                        VStack {
                            HStack {
                                Text("Getting there")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                Spacer()
                            }.padding(.leading)
                            Text(meetupAddress)
                                .font(.subheadline)
                                .padding()
                        }.padding()
                        VStack {
                            Button(action: {}, label: {
                                Text("Register")
                                    .font(.headline)
                            })
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                    }.padding()
                }.navigationTitle(title)
            }
        }
    }
}
