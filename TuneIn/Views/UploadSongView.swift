//
//  UploadSongView.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/17/23.
//

import SwiftUI

struct UploadSongView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @Binding var name: String
    @State private var songUploaded = false
    @Binding var usernm: String
    @State private var songTitle = ""
    @State private var artistName = ""
    @Binding var userID: String
    
    var body: some View {
        
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
//                ForEach(dataManager.songs, id: \.id) { song in
//                    Text(song.song_name)
//                }
                
                ZStack {
                    HStack {
                        Image("left")
                            .frame(alignment: .leading)
                            .padding(.leading,  20)
                        Spacer()
                    }
                    
                    
                    HStack {
                        Text("Upload Song")
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                }
                
                NavigationView {
                    Form {
                        Section(header: Text("Song Title")
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                        .foregroundColor(.white)) {
                            TextField("Enter song title", text: $songTitle)
                                .font(.custom("Poppins", size: 16))
                                .background(Color.white.opacity(0.5))
                                
                        }
                        .textCase(nil)

                        Section(header: Text("Artist Name")
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                        .foregroundColor(.white)) {
                            TextField("Enter artist name", text: $artistName)
                                .font(.custom("Poppins", size: 16))
                                .background(Color.white.opacity(0.5))
                        }
                        .textCase(nil)
                    }
                    .listStyle(GroupedListStyle())
                    .scrollContentBackground(.hidden)
                    .background(Color("Dark Blue"))
                    .onTapGesture {
                        self.hideKeyboard()
                    }
                }


                
                Spacer()
                
                HStack{
                    Button(action: {
                                self.songUploaded = true
                        dataManager.addSong(artist: artistName, song_name: songTitle)
                            }) {
                                Text(songUploaded ? "Song Uploaded" : "Upload song")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 230, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 30).fill(songUploaded ? Color.green : Color.blue).shadow(radius: 3))
                            }
                    
//                    Text("Upload song")
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-Regular", size: 16))
//                        .fixedSize(horizontal: false, vertical: true)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                        .frame(width: 230, height: 50)
//                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                }
            }
        }
    }
}

struct UploadSongView_Previews: PreviewProvider {
    static var previews: some View {
        UploadSongView(name: .constant("John Doe"), usernm: .constant("username"),userID: .constant("UniqueID"))
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

