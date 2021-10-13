//
//  PostView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 2021-09-25.
//

import SwiftUI
import Foundation

struct PostView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var title: String = ""
    @State var description: String = ""
    @State var address: String = ""
    @State var name: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var isVaccineRequired: Bool = true
    @State var isTestingRequired: Bool = true
    @State var isMaskRequired: Bool = true
    @State var people: String = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("The Basics")) {
                        TextField("Title", text: $title)
                        DatePicker(
                            "Meetup Date",
                            selection: $date,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.graphical)
                        TextField("Description", text: $description)
                        TextField("Address", text: $address)
                        TextField("Max Number of People", text: $people)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Contact Information")) {
                        TextField("Name", text: $name)
                            .disableAutocorrection(true)
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Safety Information")) {
                        Toggle(isOn: $isVaccineRequired) {
                            Text("Vaccination Required")
                        }
                        Toggle(isOn: $isTestingRequired) {
                            Text("COVID-19 Testing Required")
                        }
                        Toggle(isOn: $isMaskRequired) {
                            Text("Mask Required")
                        }
                    }
                    
                    Section {
                        Button(action: {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMMM dd, yyyy '@' h:mm a"
                            let activity = Activity(
                                title: title,
                                author: name,
                                date: dateFormatter.string(from: date),
                                address: address,
                                description: description,
                                posterEmail: email,
                                posterPhoneNumber: phoneNumber,
                                isVaccineRequired: isVaccineRequired,
                                isTestingRequired: isTestingRequired,
                                isMaskRequired: isMaskRequired,
                                people: Int(people) ?? 0)
                            viewModel.postActivity(activity: activity)
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Post")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        })
                        .foregroundColor(Color(.white))
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
                .navigationBarTitle("Plan a Meetup 🎉")
        }
    }
}
