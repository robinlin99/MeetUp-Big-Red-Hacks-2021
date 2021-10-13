//
//  Model.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/25/21.
//

import Foundation
import FirebaseAuth

struct Activity: Identifiable {
    public let id = UUID()
    public var title: String
    public var author: String
    public var date: String
    public var address: String
    public var description: String
    public var posterEmail: String
    public var posterPhoneNumber: String
    public var isVaccineRequired: Bool
    public var isTestingRequired: Bool
    public var isMaskRequired: Bool
    public var people: Int
}

struct Profile: Identifiable {
    public var name: String
    public var email: String
    var id: String {
        email
    }
}
