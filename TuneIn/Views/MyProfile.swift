import SwiftUI


struct MyProfile: View {

    @EnvironmentObject var dataManager: DataManager
    @State var uploadedSongs = [Song]()
    @Binding var name: String
    @Binding var usernm: String
    @Binding var userID: String
    // MARK: Custom back button code
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image("left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
    }


    var body: some View {
        NavigationView {
            ZStack {
                Color("Dark Blue")
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 5) {
                    Text("Uploaded Songs")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 30))
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(uploadedSongs) { song in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color("RoundRect"))
                                        .opacity(0.9)

                                    /*
                                     .background(Color("RoundRect"))
                                     .opacity(0.9)
                                     */
                                    HStack(spacing: 16) {
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
                                        .padding(.trailing, 10)

                                        // Display song name, artist, and album
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(song.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("\(song.artist) - \(song.album)")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .background(Color("Dark Blue"))
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            }
            // Enables Custom back button
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)
            .onAppear {
                dataManager.getUserSongs(userID: userID) { songs in
                    print("[DEBUG] Successfully got the current user's songs")
                    self.uploadedSongs = songs
                }
            }

        }
    }
}
