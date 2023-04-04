//
//  ConfirmSongUpload.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import SwiftUI

struct ConfirmSongUpload: View {
    
    @EnvironmentObject var dataManager: DataManager
    //@Binding var isSearchBarHidden: Bool
    @Binding var name: String
    @Binding var userID: String
    var selectedSong: Song
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Confirm Song Upload")
                    .frame(alignment: .center)
                    .foregroundColor(.white)
                    .font(.custom("Poppins-SemiBold", size: 30))
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background (
                            VStack {
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
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(.white)
                                                        .frame(width: 40, height: 40)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            .frame(width: 200, height: 200)

                                            Text(selectedSong.name)
                                                .font(.title)
                                                .foregroundColor(.white)
                                                //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                                            Text("\(selectedSong.artist) - \(selectedSong.album)")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                //.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                                            //Spacer()
                                        }
                                        .frame(maxWidth: 400, maxHeight: 200)
                        )

                }
                Spacer()
                NavigationLink(destination: Home()) { //to do - change to feedempty
                    Text("Upload song")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                    //.padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
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
                
                // Display song information
                
                

            }
            .padding()
            .navigationBarTitle("Confirm Upload", displayMode: .inline)
            .navigationBarHidden(true)
            
            .foregroundColor(.white)

        }
    }
}


struct ConfirmSongUpload_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSongUpload( name: .constant("Joe"), userID: .constant("UNIQUEID"), selectedSong: Song(id: "uniqueid", artist: "taylor swift", name: "this is me trying", coverArt: "https://i.scdn.co/image/ab67616d00001e02a9c080fdc40e78a4b81e0520", album: "folklore"))
    }
}
