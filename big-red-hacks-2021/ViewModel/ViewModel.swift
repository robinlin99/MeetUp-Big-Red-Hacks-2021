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
    var currentAuthUser: User? {
        auth.currentUser
    }
    var currentUserProfile: Profile? = nil
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
                self.db.collection("users").document(self.currentAuthUser!.uid).setData([
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
        //Set the current user profile.
        currentUserProfile = Profile(name: name, email: email)
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
                    let address: String = document.data()["address"] as! String
                    let description: String = document.data()["description"] as! String
                    let email: String = document.data()["email"] as! String
                    let phone: String = document.data()["phone"] as! String
                    let isVaccineRequired: Bool = document.data()["isVaccineRequired"] as! Bool
                    let isTestingRequired: Bool = document.data()["isTestingRequired"] as! Bool
                    let isMaskRequired: Bool = document.data()["isMaskRequired"] as! Bool
                    let people: Int = document.data()["people"] as! Int
                    
                    let activity = Activity(
                        title: title,
                        author: author,
                        date: date,
                        address: address,
                        description: description,
                        posterEmail: email,
                        posterPhoneNumber: phone,
                        isVaccineRequired: isVaccineRequired,
                        isTestingRequired: isTestingRequired,
                        isMaskRequired: isMaskRequired,
                        people: people)
                    self.activities.append(activity)
                }
            }
        }
    }
    
    func loadUserProfile() {
        // Extract the name from db.
        if currentAuthUser != nil {
            usersRef.document(currentAuthUser!.uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let name = document.data()!["name"] as! String
                    let email = document.data()!["email"] as! String
                    self.currentUserProfile = Profile(name: name, email: email)
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func postActivity(activity: Activity) {
        let id = activity.id
        let title = activity.title
        let author = activity.author
        let date = activity.date
        let meetupAddress = activity.address
        let description = activity.description
        let email = activity.posterEmail
        let phone = activity.posterPhoneNumber
        let isVaccineRequired = activity.isVaccineRequired
        let isTestingRequired = activity.isTestingRequired
        let isMaskRequired = activity.isMaskRequired
        let people = activity.people
        
        // Add to posts
        db.collection("posts").document("\(id)").setData([
            "id": id.uuidString,
            "title": title,
            "author": author,
            "date": date,
            "address": meetupAddress,
            "description": description,
            "email": email,
            "phone": phone,
            "isVaccineRequired": isVaccineRequired,
            "isTestingRequired": isTestingRequired,
            "isMaskRequired": isMaskRequired,
            "people": people
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // Add to user posts
        db.collection("users").document(currentAuthUser!.uid).updateData([
            "posts": FieldValue.arrayUnion([id.uuidString]),
            "meets": FieldValue.arrayUnion([id.uuidString])
        ])
    }
}
