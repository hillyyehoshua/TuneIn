//
//  UploadSongView.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/17/23.
//

import SwiftUI

struct UploadSongView: View {

    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var name: String
    @State private var songUploaded = false
    @Binding var usernm: String
    @State private var songTitle = ""
    @State private var artistName = ""
    @Binding var userID: String

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

        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)

            VStack {

//                ForEach(dataManager.songs, id: \.id) { song in
//                    Text(song.song_name)
//                }

                ZStack {

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
//                        dataManager.addSong(song: <#Song#>, artist: artistName, song_name: songTitle)
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct UploadSongView_Previews: PreviewProvider {
    static var previews: some View {
        UploadSongView(name: .constant("ijeds"), usernm: .constant("lkewuslk"), userID: .constant("dsfdfskf"))
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

