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
                    let phone = data["phone"] as? String ?? ""
                    let timezone = data["timezone"] as? String ?? ""
                    /*
                     var phone: Int
                     var timezone: String
                     */
                    
                    let user = User(id: id, name: name, username: username, phone: phone, timezone: timezone)
                    self.users.append(user)
                }
            }
        }
    }
    
    
    func addUser(name: String, username: String, phone: String, timezone: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(name)
        
        var timezoneString = ""
        if let intValue = Int(timezone) {
            if (intValue == 1){
                timezoneString = "America"
            } else if (intValue == 2){
                timezoneString = "Europe"
            } else if (intValue == 3){
                timezoneString = "East Asia"
            } else if (intValue == 4){
                timezoneString = "West Asia"
            }
        }
        
        ref.setData(["name": name, "username": username, "id": UUID().uuidString, "phone" : phone, "timezone": timezoneString]){
            error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
