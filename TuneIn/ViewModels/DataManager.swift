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
    @Published var currentUser: User = User()
    
   init(){
       fetchUsers { result in
           switch result {
           case .success(let users):
               self.users = users
           case .failure(let error):
               print("[DEBUG] Error fetching users")
           }
       }
       fetchSongs { songs, error in
           if let error = error {
               print("[DEBUG] Error fetching songs: \(error.localizedDescription)")
           } else if let songs = songs {
               print("[DEBUG] Fetched \(songs.count) songs.")
           }
       }

       fetchCurrentUser { user, error  in
           if error != nil {
               print("[DEBUG] Error fetching current user")
           } else if let user = user {
               print("[DEBUG] Fetched current user with id: \(user.id)")
               self.currentUser = user
           }
       }
    }
    
    //MARK: Reading data from Firestore
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        users.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Users")
        
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let timezone = data["timezone"] as? String ?? ""
                    let friends = data["friends"] as? [String] ?? [""]
                    let uploadedSongs = data["uploadedSongs"] as? [String] ?? [""]
                    let didDailyPost = data["didDailyPost"] as? Bool ?? false

                    let user = User(id: id, name: name, username: username, phone: phone, timezone: timezone, friends: friends, uploadedSongs: uploadedSongs, didDailyPost: didDailyPost)
                    self.users.append(user)
                }
                completion(.success(self.users))
            } else {
                completion(.failure(NSError(domain: "DataManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Snapshot is nil"])))
            }
        }
    }
    
    func getUserFriendsAndLastSongUpload(userID: String, completion: @escaping ([(friendName: String, friendUsername: String, song: Song)]?, Error?) -> Void) {
        let userRef = Firestore.firestore().collection("Users").document(userID)
        userRef.getDocument { (snapshot, error) in
            if let error = error {
                print("[DEBUG] Error fetching user data: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let snapshot = snapshot else {
                print("[DEBUG] No snapshot found for user with ID \(userID)")
                completion(nil, nil)
                return
            }
            print("[DEBUG] user id here \(userID)")
            guard let userData = snapshot.data(),
                  let friendsIDs = userData["friends"] as? [String] else {
                print("[DEBUG] No user data found for user with ID \(userID)")
                completion(nil, nil)
                return
            }
            
            var friendsWithSongs: [(friendName: String, friendUsername: String, song: Song)] = []
            let dispatchGroup = DispatchGroup()
            
            for friendID in friendsIDs {
                print("[DEBUG] inside here")
                let friendRef = Firestore.firestore().collection("Users").document(friendID)
                dispatchGroup.enter()
                friendRef.getDocument { (friendSnapshot, friendError) in
                    defer {
                        dispatchGroup.leave()
                    }
                    if let friendError = friendError {
                        print("[DEBUG] Error fetching friend data for user with ID \(friendID): \(friendError.localizedDescription)")
                        return
                    }
                    guard let friendData = friendSnapshot?.data(),
                          let friendName = friendData["name"] as? String,
                          let friendUsername = friendData["username"] as? String,
                          let didDailyPost = friendData["didDailyPost"] as? Bool,
                          didDailyPost == true,
                          let uploadedSongsIDs = friendData["uploadedSongs"] as? [String],
                          !uploadedSongsIDs.isEmpty else {
                        print("[DEBUG] No friend data found for user with ID \(friendID) or friend didn't do daily post")
                        return
                    }
                    
                    if let lastSongID = uploadedSongsIDs.last {
                        let songRef = Firestore.firestore().collection("Songs").document(lastSongID)
                        dispatchGroup.enter()
                        songRef.getDocument { (songSnapshot, songError) in
                            defer {
                                dispatchGroup.leave()
                            }
                            if let songError = songError {
                                print("[DEBUG] Error fetching song data for song with ID \(lastSongID): \(songError.localizedDescription)")
                                return
                            }
                            guard let songData = songSnapshot?.data(),
                                  let songArtist = songData["artist"] as? String,
                                  let songTitle = songData["name"] as? String,
                                  let songCoverArt = songData["coverArt"] as? String,
                                  let songAlbum = songData["album"] as? String else {
                                print("[DEBUG] No song data found for song with ID \(lastSongID)")
                                return
                            }
                            let song = Song(id: lastSongID, artist: songArtist, name: songTitle, coverArt: songCoverArt, album: songAlbum)
                            let friendData = (friendName: friendName, friendUsername: friendUsername, song: song)
                            print("[DEBUG] Appended song with name: \(songTitle)")
                            
                            friendsWithSongs.append(friendData)
                        }
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                print("[DEBUG]: Exiting feed function here")
                print("[DEBUG]: \(friendsWithSongs)")
                completion(friendsWithSongs, nil)
            }
        }
    }



                                


    
    
    func fetchSongs(completion: @escaping ([Song]?, Error?) -> Void) {
        songs.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Songs")
        
        ref.getDocuments{ snapshot, error in
            guard error == nil else{
                print (error!.localizedDescription)
                completion(nil, error)
                return
            }
            
            var fetchedSongs = [Song]()
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let artist = data["artist"] as? String ?? ""
                    let coverArt = data["coverArt"] as? String ?? ""
                    let album = data["album"] as? String ?? ""
                    
                    let song = Song(id: id, artist: artist, name: name, coverArt: coverArt, album: album)
                    fetchedSongs.append(song)
                }
            }
            
            self.songs = fetchedSongs
            completion(fetchedSongs, nil)
        }
    }

    
    func fetchCurrentUser(completion: @escaping (User?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "fetchCurrentUser", code: 0, userInfo: [NSLocalizedDescriptionKey: "No current user"]))
            return
        }
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(uid)
        userDoc.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                completion(nil, NSError(domain: "fetchCurrentUser", code: 1, userInfo: [NSLocalizedDescriptionKey: "Current user document not found"]))
                return
            }
            guard let userData = document.data() else {
                completion(nil, NSError(domain: "fetchCurrentUser", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error getting current user data"]))
                return
            }
            let currentUser = User(id: uid, name: userData["name"] as? String ?? "", username: userData["username"] as? String ?? "", phone: userData["phone"] as? String ?? "", timezone: userData["timezone"] as? String ?? "", friends: userData["friends"] as? [String] ?? [], uploadedSongs: userData["uploadedSongs"] as? [String] ?? [], didDailyPost: userData["didDailyPost"] as? Bool ?? false)
            completion(currentUser, nil)
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
    
    func getUserFriends(userID: String, completion: @escaping ([Dictionary<String, String>]?, Error?) -> Void) {
            
        print("[DEBUG] Getting friends for userID: \(userID)")
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userID)
        userDoc.getDocument { (document, error) in
            if let error = error {
                print("[DEBUG] Error getting user document: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                print("[DEBUG] User document not found")
                completion(nil, nil)
                return
            }
            print("[DEBUG] User document found")
            guard let userData = document.data(), let friendIDs = userData["friends"] as? [String] else {
                print("[DEBUG] Error getting user data or friend IDs")
                completion(nil, nil)
                return
            }
            print("[DEBUG] Friend IDs found: \(friendIDs)")
            var friendsData: [Dictionary<String, String>] = []
            let group = DispatchGroup()
            for friendID in friendIDs {
                group.enter()
                self.getUserData(userID: friendID) { data, error in
                    defer {
                        group.leave()
                    }
                    if let error = error {
                        print("[DEBUG] Error retrieving friend's data: \(error.localizedDescription)")
                    } else if let data = data {
                        print("[DEBUG] Friend data found: \(data)")
                        friendsData.append(data)
                    } else {
                        print("[DEBUG] No data found for friend with ID \(friendID).")
                    }
                }
            }
            group.notify(queue: .main) {
                print("[DEBUG] Success getting friends")
                completion(friendsData, nil)
            }
        }
    }

    func getUserData(userID: String, completion: @escaping (Dictionary<String, String>?, Error?) -> Void) {
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userID)
        userDoc.getDocument { (document, error) in
            if let error = error {
                print("[DEBUG] Error getting user document: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                print("[DEBUG] User document not found")
                completion(nil, nil)
                return
            }
            print("[DEBUG] User document found")
            guard let userData = document.data(), let name = userData["name"] as? String, let username = userData["username"] as? String else {
                print("[DEBUG] Error getting user data")
                completion(nil, nil)
                return
            }
            print("[DEBUG] User data found: \(userData)")
            let friendData: [String: String] = ["id": userID, "name": name, "username": username]
            completion(friendData, nil)
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
                print("[DEBUG] Error retrieving user document: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
            }
        }
    }
    //END: reading from Firestore

    
    // MARK: Writing to Firestore functions
        
    func addUser(name: String, username: String, phone: String, timezone: String, friends: [String], uploadedSongs: [String], didDailyPost: Bool, completion: @escaping (String?, Error?) -> Void) {
        
        guard let uid = AuthManager.shared.auth.currentUser?.uid else {
            print("[DEBUG] IN ADD USER FUNCTION: uid was nil")
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
            "uploadedSongs": uploadedSongs,
            "didDailyPost": didDailyPost
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
        print("[DEBUG] Song ID: \(songID)")
        print("[DEBUG] User ID: \(userId)")
        
        // Create a reference to the Firestore database
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(userId)
        
        // Update the user document with the song ID using the "arrayUnion" method
        ref.updateData([
            "uploadedSongs": FieldValue.arrayUnion([songID]),
            "didDailyPost": true
        ]) { error in
            // Handle any errors that occur during the update operation
            if let error = error {
                print("[DEBUG] Error adding song to user: \(error.localizedDescription)")
            } else {
                // If there are no errors, print a success message
                print("[DEBUG] Song added to user successfully!")
            }
        }
    }

    
    func addSong(song: Song, completion: @escaping (Result<String, Error>) -> Void) {
        
        print("[DEBUG] Song beging added to firestore: \(song)")
        
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
                print("[DEBUG] Error adding song")
                completion(.failure(error))
            } else {
                print("[DEBUG] Song added successfully!")
                completion(.success(id))
            }
        }
    }


    func addFriendToUser(userId: String, friendId: String) {
        
        print ("This is user.id: (friends) \(friendId)")
        print ("This is my ID: (me) \(userId)")
        
        print("[DEBUG] We have started the function")
        
        let db = Firestore.firestore()
        
        print("[DEBUG] DB instantiated")
        
        let userDoc = db.collection("Users").document(userId)
        
        print("[DEBUG] Got the user doc successfully")
        
        userDoc.updateData([
            "friends": FieldValue.arrayUnion([friendId])
        ]) { error in
            if let error = error {
                // Handle the error
                print("[DEBUG] Error adding friend: \(error)")
            } else {
                print("[DEBUG] Friend added successfully.")
                print("[DEBUG] Friends: \(FieldValue.arrayUnion([friendId]))")

            }
        }
        print("[DEBUG] Exiting addFriendtoUser")
    }
    
    func removeFriendFromUser(userid: String, friendid: String) {
        // Retrieve the document reference for the user
        let db = Firestore.firestore()
        let userDoc = db.collection("Users").document(userid)
        
        print("[DEBUG] friend id to remove: \(friendid)")
        
        // Update the friends field with a new friend list without the friend to be removed
        userDoc.updateData(["friends": FieldValue.arrayRemove([friendid])]) { error in
            if let error = error {
                print("[DEBUG] Error removing friend: \(error.localizedDescription)")
            } else {
                print("[DEBUG] Friend removed successfully.")
                userDoc.getDocument { document, error in
                    if let error = error {
                        print("[DEBUG] Error fetching document: \(error.localizedDescription)")
                    } else if let document = document {
                        let friends = document.get("friends") as? [String] ?? []
                        print("[DEBUG] Updated friend list: \(friends)")
                    } else {
                        print("[DEBUG] Document does not exist.")
                    }
                }
            }
        }
    }
    //END: writing to Firestore

    
    // MARK: Helper functions
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
                print("[DEBUG] Error retrieving user document: \(error?.localizedDescription ?? "Unknown error")")
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
                    print("[DEBUG] Error fetching documents: \(error.localizedDescription)")
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
    
    func resetDidDailyPostProperty() {
        let db = Firestore.firestore()
        let usersCollection = db.collection("Users")
        usersCollection.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting users: \(error)")
                return
            }
            guard let snapshot = snapshot else {
                print("No user data available")
                return
            }
            let batch = db.batch()
            snapshot.documents.forEach { (document) in
                let userId = document.data()["id"] as! String
                let userRef = usersCollection.document(userId)
                batch.updateData(["didDailyPost": false], forDocument: userRef)
            }
            batch.commit { (error) in
                if let error = error {
                    print("Error resetting didDailyPost property: \(error)")
                } else {
                    print("didDailyPost property successfully reset for all users")
                }
            }
        }
    }
    



    // END: Helper functions

}

