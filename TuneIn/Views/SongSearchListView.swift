

import SwiftUI

struct SongSearchListView: View {
    
    @Binding private var name: String
    @Binding private var userID: String
    @State private var searchText: String = ""
    @State private var songs: [Song]
    @State private var selectedSong: Song?
    @State private var isSearchBarHidden = false
    @Environment(\.presentationMode) var presentationMode

    init(name: Binding<String>, userID: Binding<String>, songs: [Song]) {
        self._name = name
        self._userID = userID
        self._songs = State(initialValue: songs)
    }
    
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
                NavigationStack {
                    List(songs, id: \.self, selection: $selectedSong) { song in
                        NavigationLink(destination: ConfirmSongUpload(isSearchBarHidden: $isSearchBarHidden, name: $name, userID: $userID, selectedSong: song)) {
                            HStack {
                                // Display cover art
                                AsyncImage(url: URL(string: song.coverArt)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        Image(systemName: "xmark.circle")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 50, height: 50)
                                
                                // Display song name, artist, and album
                                VStack(alignment: .leading) {
                                    Text(song.name)
                                        .font(.headline)
                                    Text("\(song.artist) - \(song.album)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .tag(song)
                            .onTapGesture {
                                // Dismiss the root view when a song is selected
                                self.selectedSong = song
                            }
                        }

                    }
                    .navigationTitle("Song Search")
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
        .onDisappear {
            if selectedSong != nil {
                // Dismiss the whole view when selectedSong is not nil
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}


struct SongSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchListView(name: .constant("Joe"), userID: .constant("UNQIUEID"), songs: [Song(id: "uniqueid", artist: "taylor swift", name: "this is me trying", coverArt: "https://i.scdn.co/image/ab67616d00001e02a9c080fdc40e78a4b81e0520", album: "folklore")])
    }
}
