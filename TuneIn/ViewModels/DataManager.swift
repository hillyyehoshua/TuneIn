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
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userId)
       
        userDoc.updateData([
            "friends": FieldValue.arrayUnion([friendId])
        ]) { error in
            if let error = error {
                // Handle the error
                print("Error adding friend: \(error)")
            } else {
                print("Friend added successfully.")
            }
        }
//        let db = Firestore.firestore()
//        let userRef = db.collection("Users").document(userId)
//        userRef.updateData([
//            "friends": FieldValue.arrayUnion([friendId])
//        ]) { error in
//            if let error = error {
//                completion(error)
//            } else {
//                completion(nil)
//            }
//        }
    }
    
    /*
     let userId = "ABC123" // the ID of the user you want to modify
     let friendId = "DEF456" // the ID of the friend you want to add

     addFriendToUser(userId: userId, friendId: friendId) { error in
         if let error = error {
             print("Error adding friend: \(error.localizedDescription)")
         } else {
             print("Friend added successfully.")
         }
     }
     */

    
    func addUser(name: String, username: String, phone: String, timezone: String, friends: [String], completion: @escaping (String?, Error?) -> Void) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document()
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
            "id": ref.documentID,
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
