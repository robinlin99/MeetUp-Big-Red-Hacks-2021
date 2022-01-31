//
//  ActivityInfoView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/26/21.
//

import Foundation
import SwiftUI

struct MetaInfoView: View {
    var text: String
    var icon: String
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: width,
                       height: height)
                .foregroundColor(.secondary)
            Text(text)
                .font(.headline)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

struct ActivityInfoView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var appStateModel: AppStateModel

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
                        // MARK: Title.

                        HStack {
                            Text("\(title) hosted by \(author)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            Spacer()
                        }.padding(.horizontal)

                        // MARK: Basic Information.

                        Group {
                            VStack {
                                // Contact Info.
                                MetaInfoView(text: "\(posterPhone) • \(posterEmail)", icon: "person.circle", width: geometry.size.width * 0.05, height: geometry.size.width * 0.05)
                                    .padding(.horizontal)
                                // Meet Time.
                                MetaInfoView(text: date, icon: "calendar.circle", width: geometry.size.width * 0.05, height: geometry.size.width * 0.05)
                                    .padding(.horizontal)
                            }.padding(.horizontal)
                            Divider().padding()
                        }

                        // MARK: Description.

                        Group {
                            VStack {
                                HStack {
                                    Text("Meetup details")
                                        .font(.title3)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }.padding(.horizontal)
                                Text(description)
                                    .font(.body)
                                    .padding()
                            }.padding()
                            Divider().padding()
                        }

                        // MARK: Getting there.

                        Group {
                            VStack {
                                HStack {
                                    Text("Getting there")
                                        .font(.title3)
                                        .fontWeight(.heavy)
                                    Spacer()
                                }.padding(.horizontal)
                                Text(meetupAddress)
                                    .font(.body)
                                    .padding()
                            }.padding()
                            Divider().padding()
                        }

                        // MARK: Book Button

                        VStack {
                            Button(action: {
                                viewModel.bookActivity(activity: activity)
                            }, label: {
                                Text("Register")
                                    .font(.headline)
                            })
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                    }.padding(.leading)
                }
            }
        }
    }
}
