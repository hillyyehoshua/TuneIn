//
//  TuneInApp.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI
import Firebase

@main
struct TuneInApp: App {
    @StateObject var dataManager = DataManager()
    
    init (){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            listView()
                .environmentObject(dataManager)
//            ContentView()
//                .environmentObject(dataManager)
        }
    }
}
