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

enum Tab {
    case discover
    case post
    case profile
}

class AppStateModel: ObservableObject {
    @Published var currentTab: Tab = .discover
    
    func switchState(to tab: Tab) {
        currentTab = tab
    }
}

class ViewModel: ObservableObject {
    // MARK: Authentication.
    let auth = Auth.auth()
    
    // MARK: Firestore References.
    let db = Firestore.firestore()
    var usersRef: CollectionReference {
        db.collection("users")
    }
    var postsRef: CollectionReference {
        db.collection("posts")
    }
    var supportRef: CollectionReference {
        db.collection("support")
    }
    
    // MARK: Profile.
    var currentAuthUser: User? {
        auth.currentUser
    }
    var currentUserProfile: Profile? = nil
    @Published var isSignedIn: Bool = false
    
    // MARK: All Activities (including non-registered activities).
    // Empty initialization.
    @Published var activities: [Activity] = [Activity]()
    var activitiesCount: Int {
        activities.count
    }
    
    // MARK: Activities posted by the user.
    @Published var postedActivityIDs: [String] = [String]()
    var postedActivities: [Activity] {
        activities.filter( { postedActivityIDs.contains($0.id.uuidString) } )
    }
    
    // MARK: Registered Activities (including registered activities and posted activities by user).
    // Empty initialization.
    @Published var registeredActivityIDs: [String] = [String]()
    var registeredActivities: [Activity] {
        activities.filter( { registeredActivityIDs.contains($0.id.uuidString) } )
    }
    
    // MARK: Support Info.
    var supportInfo: String = ""

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if result != nil && error == nil {
                self.isSignedIn = true
            }
        }
    }
    
    func signUp(name: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if result != nil && error == nil {
                self.isSignedIn = true
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
                    }
                }
            }
        }
        
        //Set the current user profile.
        currentUserProfile = Profile(name: name, email: email)
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.isSignedIn = false
        } catch {
            print("Error occured while signing out!")
        }
    }
    
    func loadActivities() {
        postsRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.activities.removeAll()
                for document in querySnapshot!.documents {
                    self.activities.append(
                        Activity(
                            id: UUID(uuidString: document.documentID) ?? UUID(),
                            title: document.data()["title"] as! String,
                            author: document.data()["author"] as! String,
                            date: document.data()["date"] as! String,
                            address: document.data()["address"] as! String,
                            description: document.data()["description"] as! String,
                            posterEmail: document.data()["email"] as! String,
                            posterPhoneNumber: document.data()["phone"] as! String,
                            isVaccineRequired: document.data()["isVaccineRequired"] as! Bool,
                            isTestingRequired: document.data()["isTestingRequired"] as! Bool,
                            isMaskRequired: document.data()["isMaskRequired"] as! Bool,
                            people: document.data()["people"] as! Int
                        )
                    )
                }
            }
        }
    }
    
    func loadRegisteredActivities() {
        if currentAuthUser != nil {
            usersRef.document(currentAuthUser!.uid).getDocument { (document, error) in
                guard let document = document, document.exists else {
                    fatalError("Document does not exist")
                }
            
                self.registeredActivityIDs = document.data()!["meets"] as! [String]
            }
        }
    }
    
    func loadPostedActivities() {
        if currentAuthUser != nil {
            usersRef.document(currentAuthUser!.uid).getDocument { (document, error) in
                guard let document = document, document.exists else {
                    fatalError("Document does not exist")
                }
            
                self.postedActivityIDs = document.data()!["posts"] as! [String]
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
    
    func loadSupportInfo() {
        if currentAuthUser != nil {
            supportRef.document("help-and-support").getDocument { (document, error) in
                guard let document = document, document.exists else {
                    fatalError("Document does not exist")
                }
            
                self.supportInfo = document.data()!["content"] as! String
            }
        }
    }
    
    func postActivity(activity: Activity) {
        // Add to posts.
        db.collection("posts").document("\(activity.id.uuidString)").setData([
            "id": activity.id.uuidString,
            "title": activity.title,
            "author": activity.author,
            "date": activity.date,
            "address": activity.address,
            "description": activity.description,
            "email": activity.posterEmail,
            "phone": activity.posterPhoneNumber,
            "isVaccineRequired": activity.isVaccineRequired,
            "isTestingRequired": activity.isTestingRequired,
            "isMaskRequired": activity.isMaskRequired,
            "people": activity.people
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        // Add to user posts.
        db.collection("users").document(currentAuthUser!.uid).updateData([
            "posts": FieldValue.arrayUnion([activity.id.uuidString]),
            "meets": FieldValue.arrayUnion([activity.id.uuidString])
        ])
    }
    
    func bookActivity(activity: Activity) {
        // Check if activity can be added.
        usersRef.document(currentAuthUser!.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let meets = document.data()!["meets"] as! [String]
                let posts = document.data()!["posts"] as! [String]
                guard !meets.contains(activity.id.uuidString) && !posts.contains(activity.id.uuidString) else {
                    return
                }
            } else {
                print("Document does not exist")
            }
        }
        // Add to current user activity.
        db.collection("users").document(currentAuthUser!.uid).updateData([
            "meets": FieldValue.arrayUnion([activity.id.uuidString])
        ])
    }
}
