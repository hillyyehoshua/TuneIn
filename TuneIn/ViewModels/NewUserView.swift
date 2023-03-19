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
    
    var body: some View {
        VStack {
            TextField("name", text: $newUser)
            TextField("username", text: $newUserName)
            Button {
                dataManager.addUser(name: newUser, username: newUserName)
                
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


