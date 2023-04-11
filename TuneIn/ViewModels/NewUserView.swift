//
//  NewUserView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/19/23.
//

import SwiftUI

struct NewUserView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State private var newUser = ""
    @State private var newUserName = ""
    @State private var newPhone = ""
    @State private var newTimeZone = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $newUser)
            TextField("username", text: $newUserName)
            TextField("Phone", value: $newPhone, formatter: NumberFormatter())

            TextField("timezone", text: $newTimeZone)
            Button {
                
                dataManager.addUser(name: newUser, username: newUserName, phone: newPhone, timezone: newTimeZone, friends: [], uploadedSongs: [], didDailyPost: false) { userID, error in
                    if let userID = userID {
                        // Do something with the created user ID
                        print("Created user ID: \(userID)")
                    } else {
                        // Handle the error
                        print("Failed to create user: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
                
            }label: {
                Text("save")
            }
        }
        .padding()
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}


