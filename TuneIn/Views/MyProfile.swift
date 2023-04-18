//
//  SwiftUIView.swift
//  TuneIn
//
//  Created by Izzy Hood on 4/18/23.
//

import SwiftUI

struct MyProfile: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State var uploadedSongs = [Song]()
    @Binding var name: String
    @Binding var usernm: String
    @Binding var userID: String
    
    var body: some View {
        
        ZStack {
            List {
                ForEach(uploadedSongs) { song in
                    Text(song.name)
                }
            }
        }
        .onAppear {
            dataManager.getUserSongs(userID: userID) { songs in
                print("[DEBUG] Successfully got the current user's songs")
                self.uploadedSongs = songs
            }
        }
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile(name: .constant("Joe"), usernm: .constant("Joeyphoey"), userID: .constant("uniqueid"))
    }
}
