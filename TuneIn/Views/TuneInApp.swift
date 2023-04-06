//
//  TuneInApp.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI
import Firebase
import Combine

@main
struct TuneInApp: App {
    @StateObject var dataManager = DataManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    init (){
//        FirebaseApp.configure()
//    }
//
    var body: some Scene {
        
        
        WindowGroup {
//            listView()
//                .environmentObject(dataManager)
            ContentView()
                .environmentObject(dataManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
}
