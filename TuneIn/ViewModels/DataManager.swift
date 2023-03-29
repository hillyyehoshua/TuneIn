//
//  DataManager.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/17/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject{
    @Published var users: [User] = []
    @Published var songs: [Song] = []
    
    init(){
        fetchUsers()
        fetchSongs()
    }
    
    
    
    func fetchUsers() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        
        ref.getDocuments{ snapshot, error in
            guard error == nil else{
                print (error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    //                    print (data)
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let timezone = data["timezone"] as? String ?? ""
                    let friends = data["friends"] as? [String] ?? [""]
                    
                    
                    let user = User(id: id, name: name, username: username, phone: phone, timezone: timezone, friends: friends)
                    self.users.append(user)
                }
            }
        }
    }
    
    
    func fetchSongs() {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Songs")
        
        ref.getDocuments{ snapshot, error in
            guard error == nil else{
                print (error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    //                    print (data)
                    let id = data["id"] as? String ?? ""
                    let song_name = data["song_name"] as? String ?? ""
                    let artist = data["artist"] as? String ?? ""
                    
                    
                    
                    let song = Song(id: id, artist: artist, song_name: song_name)
                    self.songs.append(song)
                }
            }
        }
    }
    
    
    
    func addSong(artist: String, song_name: String) {
        let db = Firestore.firestore()
        let docId = UUID().uuidString // create a UUID for the document ID
        let ref = db.collection("Songs").document(docId)
        
        let data: [String: Any] = [
            "id": docId,
            "artist": artist,
            "song_name": song_name
        ]
        
        ref.setData(data) { error in
            if let error = error {
                print("Error adding song: \(error.localizedDescription)")
            } else {
                print("Song added successfully!")
            }
        }
    }
    
    func addFriendToUser(userId: String, friendId: String) {
        
        print ("This is user.id: (friends) \(friendId)")
        print ("This is my ID: (me) \(userId)")
        
        print("We have started the function")
        
        let db = Firestore.firestore()
        
        print("DB instantiated")
        
        let userDoc = db.collection("Users").document(userId)
        
        print("Got the user doc successfully")
        
        userDoc.updateData([
            "friends": FieldValue.arrayUnion([friendId])
        ]) { error in
            if let error = error {
                // Handle the error
                print("Error adding friend: \(error)")
            } else {
                print("Friend added successfully.")
                print("Friends: \(FieldValue.arrayUnion([friendId]))")

            }
        }
        print("Exiting addFriendtoUser")
    }
    
    func checkFriendship(friendId: String, userId: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userId)
        userDoc.getDocument { (document, error) in
            if let document = document, document.exists {
                // Retrieve the user data dictionary from the document
                let userData = document.data()!
                // Retrieve the friends array from the user data dictionary
                let friends = userData["friends"] as! [String]
                // Check if the friend ID is in the friends array
                let isFriend = friends.contains(friendId)
                // Call the completion handler with the result
                completion(isFriend)
            } else {
                print("Error retrieving user document: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
            }
        }
    }
    
    //if there is a user with the given phone number then returns false
    func checkPhoneDoesntExists(phoneNum: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        ref.whereField("phone", isEqualTo: phoneNum)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    completion(false)
                } else {
                    guard let snapshot = snapshot else {
                        completion(false)
                        return
                    }
                    completion(!snapshot.documents.isEmpty)
                }
        }
    }


    
    
    //edited with chatgpt
    func getUserFriends(userID: String, completion: @escaping ([String]?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userID)
        userDoc.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                completion(nil, nil)
                return
            }
            guard let userData = document.data(), let friendIDs = userData["friends"] as? [String] else {
                completion(nil, nil)
                return
            }
            var friendNames: [String] = []
            let group = DispatchGroup()
            for friendID in friendIDs {
                group.enter()
                self.getUserName(userID: friendID) { name, error in
                    defer {
                        group.leave()
                    }
                    if let error = error {
                        print("Error retrieving friend's name: \(error.localizedDescription)")
                    } else if let name = name {
                        friendNames.append(name)
                    } else {
                        print("No name found for friend with ID \(friendID).")
                    }
                }
            }
            group.notify(queue: .main) {
                completion(friendNames, nil)
            }
        }
    }

    //edited with chatgpt
    func getUserName(userID: String, completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userID)
        userDoc.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                completion(nil, nil)
                return
            }
            guard let userData = document.data(), let name = userData["name"] as? String else {
                completion(nil, nil)
                return
            }
            completion(name, nil)
        }
    }


        
        
        func addUser(name: String, username: String, phone: String, timezone: String, friends: [String], completion: @escaping (String?, Error?) -> Void) {
            
            guard let uid = AuthManager.shared.auth.currentUser?.uid else {
                print("IN ADD USER FUNCTION: uid was nil")
                return
            }
            
            let db = Firestore.firestore()
            let ref = db.collection("Users").document(uid)
            let timezoneString: String
            switch Int(timezone) {
            case 1:
                timezoneString = "America"
            case 2:
                timezoneString = "Europe"
            case 3:
                timezoneString = "East Asia"
            case 4:
                timezoneString = "West Asia"
            default:
                timezoneString = ""
            }
            let data: [String: Any] = [
                "name": name,
                "username": username,
//                "id": ref.documentID,
                "id": uid,
                "phone": phone,
                "timezone": timezoneString,
                "friends": friends
            ]
            ref.setData(data) { error in
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(ref.documentID, nil)
                }
            }
        }
    }

