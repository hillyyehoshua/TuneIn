import SwiftUI

struct SongSearchListView: View {

    @Binding private var name: String
    @Binding private var userID: String
    @State private var searchText: String = ""
    @State private var songs: [Song]
    @State private var selectedSong: Song?
    @State private var isSearchBarHidden = false
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Custom back button code
    @Environment(\.presentationMode) var backbutton: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.backbutton.wrappedValue.dismiss()
    }) {
        HStack {
            Image("left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
    }
    // END: Custom back button code

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
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 43)
                    
                    HStack (alignment: .center, spacing: 0) {
                        
                        Image("search")
                            .frame(width: 25, height: 25, alignment: .leading)
                            .padding(.leading, 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        TextField("", text: $searchText)
                            .modifier(PlaceholderStyle(showPlaceHolder: searchText.isEmpty, placeholder: "Search for your new tune!"))
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        Button(action: {
                            searchTracks(query: searchText) { songs in
                                self.songs = songs
                                print(songs)
                            }
                        }, label: {
                            Text("Search")
                                .font(.custom("Poppins-Regular", size: 14))
                        })
                        .padding(.vertical)
                        .padding(.trailing, 35)
                    }
                    .padding(.leading, 25)

                }

                if !songs.isEmpty {
                    List(songs, id: \.self, selection: $selectedSong) { song in
                        NavigationLink(destination: ConfirmSongUpload(name: $name, userID: $userID, selectedSong: song)
                                        .navigationBarHidden(true)) {
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
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                }
            }
        }
        .onAppear {
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}
