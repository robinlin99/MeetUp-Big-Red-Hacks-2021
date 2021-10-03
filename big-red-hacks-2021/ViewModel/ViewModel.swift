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
    var usersRef: CollectionReference {
        db.collection("users")
    }
    var postsRef: CollectionReference {
        db.collection("posts")
    }
    
    // MARK: Profile.
    var currentUser: User? {
        auth.currentUser
    }
    @Published var isSignedIn: Bool = false
    
    // MARK: Activities.
    // Empty initialization.
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
    
    func signUp(name: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if result != nil && error == nil {
                DispatchQueue.main.async {
                    print("Success!")
                    self.isSignedIn = true
                }
                // Add user login into Firestore db.
                self.db.collection("users").document(self.currentUser!.uid).setData([
                    "name": name,
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
    
    func loadActivities() {
        postsRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.activities = []
                for document in querySnapshot!.documents {
                    let title: String = document.data()["title"] as! String
                    let author: String = document.data()["author"] as! String
                    let date: String = document.data()["date"] as! String
                    let location: GeoPoint = document.data()["location"] as! GeoPoint
                    let latitude: Double = location.latitude
                    let longitude: Double = location.longitude
                    let description: String = document.data()["description"] as! String
                    let activity = Activity(
                        title: title,
                        author: author,
                        date: date,
                        meetupLocation: (latitude, longitude),
                        description: description)
                    
                    self.activities.append(activity)
                }
            }
        }
    }
}
