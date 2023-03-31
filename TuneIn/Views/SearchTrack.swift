//
//  SearchTrack.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

//
//  SearchTrack.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import SwiftUI

struct SearchTrack: View {
    
    @State private var searchText: String = ""
    @State private var songs: [Song] = []
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        VStack {
            TextField("Enter search query", text: $searchText)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                searchTracks(query: searchText) { songs in
                    // Use the songs array returned by the completion closure here
                    self.songs = songs
                    print(songs)
                }
            }, label: {
                Text("Search")
            })
            .padding(.vertical)
            
            if !songs.isEmpty {
                SongSearchListView(songs: songs)
                    .onDisappear {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        
    }
}

struct SearchTrack_Previews: PreviewProvider {
    static var previews: some View {
        SearchTrack()
    }
}

