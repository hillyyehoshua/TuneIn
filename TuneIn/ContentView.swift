
//  ContentView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI
import FirebaseAuth

// Structure for the view that manages primary app screens and navigation.
struct ContentView: View {
    
    // TODO: FIGURE OUT HOW TO NOT HAVE THESE
    @State private var name = "Temp"
    @State private var usernm = "Temp2"
    
    var body: some View {
//        NavigationView {
//            UploadSongView()
//        }
//        VStack {
//            Spotify()
//        }
//        if Auth.auth().currentUser == nil {
            NavigationView {
                LogIn()
            }
//        }
//        else {
//            NavigationView {
//                Feed(name: $name, usernm: $usernm)
//            }
//        }
        
//        NavigationView {
//            LogIn()
//
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
