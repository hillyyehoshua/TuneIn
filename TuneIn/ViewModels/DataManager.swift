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
    
    init(){
        fetchUsers()
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
                    print (data)
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    
                    let user = User(id: id, name: name, username: username)
                    self.users.append(user)
                }
            }
        }
    }
    
    
    func addUser(name: String, username: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(name)
        ref.setData(["name": name, "username": username, "id": UUID().uuidString]){
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
