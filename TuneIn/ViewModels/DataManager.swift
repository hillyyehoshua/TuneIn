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
                    let uploadedSongs = data["uploadedSongs"] as? [String] ?? [""]

                    
                    let user = User(id: id, name: name, username: username, phone: phone, timezone: timezone, friends: friends, uploadedSongs: uploadedSongs)
                    self.users.append(user)
                }
            }
        }
    }
    
    
    func fetchSongs() {
        songs.removeAll()
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
                    let name = data["name"] as? String ?? ""
                    let artist = data["artist"] as? String ?? ""
                    let coverArt = data["coverArt"] as? String ?? ""
                    let album = data["album"] as? String ?? ""
                    
                    let song = Song(id: id, artist: artist, name: name, coverArt: coverArt, album: album)
                    self.songs.append(song)
                }
            }
        }
    }

    
    func addSong(song: Song, completion: @escaping (Result<String, Error>) -> Void) {
        
        print("Song beging added to firestore: \(song)")
        
        let db = Firestore.firestore()
        let id = UUID().uuidString
        let ref = db.collection("Songs").document(id)
        
        // Create a dictionary that represents the song data
        let data: [String: Any] = [
            "id": id,
            "artist": song.artist,
            "name": song.name,
            "coverArt": song.coverArt,
            "album": song.album
        ]
        
        // Create a new document with the song data
        ref.setData(data) { error in
            if let error = error {
                print("Error adding song")
                completion(.failure(error))
            } else {
                print("Song added successfully!")
                completion(.success(id))
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
    
    /*returns an array of tuples containing the song and the user's name for every friend in the user's database.*/
    

    func getFriendsLastUploadedSongs(userId: String, completion: @escaping ([(id: String, name: String, song: Song)]) -> Void) {
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userId)
        print ("user's id in getFriendsSong : \(userId)")


        // Fetch the user's friends
        userDoc.getDocument { (document, error) in
            if let document = document, document.exists {
                // Retrieve the user data dictionary from the document
                let userData = document.data()!
                // Retrieve the friends array from the user data dictionary
                let friends = userData["friends"] as! [String]
                
                var results: [(id: String, name: String, song: Song)] = []
                
                // Fetch the last uploaded song for each friend
                for friendId in friends {
                    db.collection("Users").document(friendId).getDocument { (document, error) in
                        if let document = document, document.exists {
                            // Retrieve the user data dictionary from the document
                            let userData = document.data()!
                            // Retrieve the user's name from the user data dictionary
                            let name = userData["name"] as! String
                            // Retrieve the user's last uploaded song from the user data dictionary
                            let uploadedSongs = userData["uploadedSongs"] as! [String]
                            if let lastUploadedSongId = uploadedSongs.last,
                               let lastUploadedSong = self.songs.first(where: { $0.id == lastUploadedSongId }) {
                                // Add the friend's ID, name, and last uploaded song to the results array
                                results.append((id: friendId, name: name, song: lastUploadedSong))
                            }
                        } else {
                            print("Error retrieving friend document: \(error?.localizedDescription ?? "Unknown error")")
                        }
                        
                        // Call the completion handler with the results array
                        completion(results)
                    }
                }
            } else {
                print("Error retrieving user document: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
            }
        }
    }


  
        
    func addUser(name: String, username: String, phone: String, timezone: String, friends: [String], uploadedSongs: [String], completion: @escaping (String?, Error?) -> Void) {
        
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
            "id": uid,
            "name": name,
            "username": username,
//                "id": ref.documentID,
            "phone": phone,
            "timezone": timezoneString,
            "friends": friends,
            "uploadedSongs": uploadedSongs
        ]
        ref.setData(data) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(ref.documentID, nil)
            }
        }
    }
    
    func addSongToUser(songID: String, userId: String) {
        
        // Print the song ID and user ID for debugging
        print("Song ID: \(songID)")
        print("User ID: \(userId)")
        
        // Create a reference to the Firestore database
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userId)
        
        // Update the user document with the song ID using the "arrayUnion" method
        ref.updateData([
            "uploadedSongs": FieldValue.arrayUnion([songID])
        ]) { error in
            // Handle any errors that occur during the update operation
            if let error = error {
                print("Error adding song to user: \(error.localizedDescription)")
            } else {
                // If there are no errors, print a success message
                print("Song added to user successfully!")
            }
        }
    }

}

