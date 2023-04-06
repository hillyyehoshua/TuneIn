
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
    @State var currUserUid = Auth.auth().currentUser?.uid
    @State var name = "Hello"
    @State var username = "Hello"
    @State var userID = "If9Qxz96WRNePQHhUhcThUvZkyj2"
    
    var body: some View {
        
        //MARK: CHANGE THE STARTING VIEW HERE TO TEST
//        NavigationView {
////            SearchTrack()
////            SongSearchListView(name: $name, userID: $userID, songs: [])
//            Home()
//        }
        if currUserUid == nil {
            NavigationView {
                Home()
            }
        } else {

            let _ = print("There is a user logged in already with uid: \(String(describing: currUserUid))")
//            let _ = dataManager.fetchCurrentUser
            NavigationView {
                FeedEmpty()
            }
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
