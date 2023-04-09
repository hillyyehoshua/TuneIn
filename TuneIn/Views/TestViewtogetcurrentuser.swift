//
//  TestViewtogetcurrentuser.swift
//  TuneIn
//
//  Created by Izzy Hood on 4/5/23.
//

import SwiftUI
import Firebase

struct TestViewtogetcurrentuser: View {
//    @ObservedObject var dataManager: DataManager
    @EnvironmentObject var dataManager: DataManager
    @State var name = ""
    
    
    var body: some View {
        Text("Welcome, \(name)")
            .onAppear {
                if Auth.auth().currentUser != nil {
                    dataManager.fetchCurrentUser { user, error  in
                        if error != nil {
                            print("Error fetching current user")
                        } else if let user = user {
                            print("Fetched current user with id: \(user.id)")
                            self.name = dataManager.currentUser.name
                        }
                    }
                }
            }
    }
}

struct TestViewtogetcurrentuser_Previews: PreviewProvider {
    static var previews: some View {
        TestViewtogetcurrentuser()
    }
}
