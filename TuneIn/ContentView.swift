
//  ContentView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI
import FirebaseAuth

// Structure for the view that manages primary app screens and navigation.
struct ContentView: View {
    
    @EnvironmentObject var dataManager: DataManager
//    @State var currUser = Auth.auth().currentUser
//    @State var name = ""
//    @State var username = ""
//    @State var userID = ""
    
    var body: some View {

//        if currUser == nil {
            NavigationView {
                Home()
            }
//        } else {
//
//            name = currUser.name
//            username = currUser.username
//            userID = currUser.id
//
//            NavigationView {
//                FeedEmpty(name: $name, usernm: $username, userID: $userID)
//            }
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
