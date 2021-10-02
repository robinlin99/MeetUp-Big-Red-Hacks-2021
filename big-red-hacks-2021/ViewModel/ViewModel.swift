//
//  ViewModel.swift
//  big-red-hacks-2021
//
//  Created by Robin Lin on 9/25/21.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class ViewModel: ObservableObject {
    // MARK: Authentication.
    let auth = Auth.auth()
    
    // MARK: Firestore.
    let db = Firestore.firestore()
    
    // MARK: Profile.
    var currentUser: User? {
        auth.currentUser
    }
    
    @Published var isSignedIn: Bool = false
    
    // MARK: Activities.
    @Published var activities: [Activity] =
        [Activity(
            title: "🍿 Watch Spiderman Homecoming",
            author: "Mary Jane Watson", date: Date(),
            meetupLocation: (37.0, 122.0),
            description: "I'm looking for people for the new Spiderman Homecoming movie. It will be fun event!"
        )]
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
                // Add user login into Firestore db.
                self.db.collection("users").document(self.currentUser!.uid).setData([
                    "email": email,
                    "password": password,
                    "posts": [],
                    "meets": []
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            } else {
                print("Error occured while signing up!")
                return
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            DispatchQueue.main.async {
                self.isSignedIn = false
            }
        } catch {
            print("Error occured while signing out!")
            return
        }
    }
}
