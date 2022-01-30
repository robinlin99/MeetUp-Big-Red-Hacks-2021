//
//  EventRowView.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 1/28/22.
//

import SwiftUI

struct EventRowView: View {
    var activity: Activity
    
    private var authorInitials: String {
        let formatter = PersonNameComponentsFormatter()
        guard let components = formatter.personNameComponents(from: activity.author) else {
            fatalError("Unable to parse poster name.")
        }
                
        formatter.style = .abbreviated
        return formatter.string(from: components)
    }
    
    var body: some View {
        HStack {
            Text(authorInitials)
                .padding()
                .background(
                    Circle()
                        .stroke(.blue, lineWidth: 4)
                      .padding(6)
                )
            VStack(alignment: .leading) {
                Text(activity.title)
                Text("Hosted By: \(activity.author)")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text("Date: \(activity.date)")
                    .font(.body)
                Text("Location: \(activity.address)")
                    .font(.body)
            }
        }
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(activity: Activity(
            id: UUID(),
            title: "Pizza Night on North Campus",
            author: "Robin Lin",
            date: "01-26-2022",
            address: "419 Triphammer Rd",
            description: "Pizza Night with friendds on North Campus",
            posterEmail: "zl755@cornell.edu",
            posterPhoneNumber: "607-379-2380",
            isVaccineRequired: true,
            isTestingRequired: true,
            isMaskRequired: true,
            people: 10)
        )
    }
}
