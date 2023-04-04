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
    
    
    func getCurrentDayOfWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack (alignment: .top, spacing: 0) {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        searchTracks(query: searchText) { songs in
                            self.songs = songs
                            print(songs)
                        }
                    }, label: {
                        Text("Search")
                    })
                    
                    .padding(.vertical)
                }
                
                if !songs.isEmpty {
                    NavigationStack {
                        //isSearchBarHidden = true
                        List(songs, id: \.self, selection: $selectedSong) { song in
                            
                            NavigationLink(destination: ConfirmSongUpload( name: $name, userID: $userID, selectedSong: song)) {
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
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
            }
        }.onAppear {
                        // Call searchTracks with the current day of the week
                        searchTracks(query: getCurrentDayOfWeek()) { songs in
                            self.songs = songs
                            print(songs)
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
