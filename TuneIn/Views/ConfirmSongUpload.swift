    //
    //  ConfirmSongUpload.swift
    //  TuneIn
    //
    //  Created by Izzy Hood on 3/30/23.
    //

    import SwiftUI

    struct ConfirmSongUpload: View {
        
        @EnvironmentObject var dataManager: DataManager
        @Binding var isSearchBarHidden: Bool
        @Binding var name: String
        @Binding var userID: String
        var selectedSong: Song
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                Text("Confirm Song Upload")
                    .font(.headline)
                
                // Display song information
                AsyncImage(url: URL(string: selectedSong.coverArt)) { phase in
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
                .frame(width: 200, height: 200)
                
                Text(selectedSong.name)
                    .font(.title)
                
                Text("\(selectedSong.artist) - \(selectedSong.album)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: Home()) {
                    Text("Upload song")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                }
                .simultaneousGesture(TapGesture().onEnded({
                    let _ = print("Pressed button that should upload song")
                    dataManager.addSong(song: selectedSong) { result in
                        switch result {
                        case .success(let songID):
                            print("New song added with ID: \(songID)")
                            dataManager.addSongToUser(songID: songID, userId: userID)
                        case .failure(let error):
                            print("Error adding song: \(error.localizedDescription)")
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }))
                
//                Button(action: {
//                    // Perform song upload and dismiss views
//                    dataManager.addSong(song: selectedSong) { result in
//                        switch result {
//                        case .success(let songID):
//                            print("New song added with ID: \(songID)")
//                            dataManager.addSongToUser(songID: songID, userId: userID)
//                        case .failure(let error):
//                            print("Error adding song: \(error.localizedDescription)")
//                        }
//                    }
//                    self.presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Text("Upload Song")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                })
            }
            .padding()
            .navigationBarTitle("Confirm Upload", displayMode: .inline)
            .navigationBarHidden(isSearchBarHidden)
            .onAppear {
                isSearchBarHidden = true
            }
            .onDisappear {
                isSearchBarHidden = false
            }
        }
    }


    struct ConfirmSongUpload_Previews: PreviewProvider {
        static var previews: some View {
            ConfirmSongUpload(isSearchBarHidden: .constant(true), name: .constant("Joe"), userID: .constant("UNIQUEID"), selectedSong: Song(id: "uniqueid", artist: "taylor swift", name: "this is me trying", coverArt: "https://i.scdn.co/image/ab67616d00001e02a9c080fdc40e78a4b81e0520", album: "folklore"))
        }
    }
