//
//  ViewModel.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/25/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ViewModel: ObservableObject {
    // MARK: Authentication
    let auth = Auth.auth()
    
    // MARK: Profile
    var currentUser: User? {
        auth.currentUser
    }
    @Published var isSignedIn: Bool = false
    
    // MARK: Activities
    @Published var activities: [Activity] = [Activity]()
    var activitiesCount: Int {
        activities.count
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) { result, error in
            if result != nil && error == nil {
                DispatchQueue.main.async {
                    print("Success!")
                    self.isSignedIn = true
                }
            } else {
                print("Error occured while signing in!")
                return
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if result != nil && error == nil {
                DispatchQueue.main.async {
                    print("Success!")
                    self.isSignedIn = true
                }
            } else {
                print("Error occured while signing up!")
                return
            }
        }
    }
}

