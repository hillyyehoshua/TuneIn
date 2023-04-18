//
//  FeedEmpty.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 2/16/23.
//

import SwiftUI
import Firebase


struct FeedEmpty: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var dataManager: DataManager
    @State var name = "..."
    @State var usernm = "..."
    @State var userID = "..."
    @State var isLoading = true
    @State var friendDataText = ""
    @State var showButton = true
    @State var lastSongName = "..."
    @State var lastSongCoverArt = "..."
    
    // MARK: Custom back button code
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack{
            //App background color
            let _ = print ("[DEBUG] user ID in feed empty \(String(describing: $userID))")
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (spacing: 17){
                //Header that does not move
                HStack{
                    //Add friends
                    NavigationLink(destination: FindFriends(name: $name, usernm: $usernm, userID: $userID)){
                        Image(systemName: "person.2.fill")
                            .foregroundColor(Color(.white))
                            .font(.system(size: 25))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    }
                    
                    //App logo
                    Text("TuneIn")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                        .font(.custom("Poppins-SemiBold", size: 32))
                    
                    //note - maybe we can add the play circle here
                    
                    //Add user's profile picture / image
                    NavigationLink(destination: Settings(name: $name, usernm: $usernm, userID: $userID)){
                        
                        ZStack {
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 40, height: 40)
                            Text(String(name.first!))
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(.black)
                        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                    }
                }
                
                //Scroll and see all of peoples' posts
                ScrollView {
                    
                    if lastSongCoverArt == "..." {
                        NavigationLink(destination: SongSearchListView(name: $name, userID: $userID, songs: [])){
                            Image("plus")
                                .resizable()
                                .frame(width: 172, height: 172)
                        }
                    } else {
                        ZStack {
                            AsyncImage(url: URL(string: lastSongCoverArt)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 172, height: 172)
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
                            .overlay(
                                NavigationLink(destination: SongSearchListView(name: $name, userID: $userID, songs: [])) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .renderingMode(.original)
                                        .foregroundColor(.red)
                                        .frame(width: 30, height: 30)
                                }
                                .frame(alignment: .bottomTrailing)
                                .offset(x: 86, y: 86)
                            )
                        }
                    }


                    let calendar = Calendar.current
                    let dayOfWeek = calendar.component(.weekday, from: Date())
                    let dayOfWeekString = calendar.weekdaySymbols[dayOfWeek - 1]

                    NavigationLink(destination: SongSearchListView(name: $name, userID: $userID, songs: [])){
                        Text("Add \(dayOfWeekString)'s Song")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-SemiBold", size: 18))
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    }
                    
                    Spacer()
                        .frame(height: 20)

                    
                    Button(action: {
                        dataManager.getUserFriendsAndLastSongUpload(userID: userID) { friendData, error in
                            if let error = error {
                                print("Error: \(error)")
                            } else if let friendData = friendData {
                                print("Friend data:")
                                var friendDataString = ""
                                for friend in friendData {
                                    let friendName = friend.friendName
                                    let friendUsername = friend.friendUsername
                                    let song = friend.song
                                    let friendDataLine = "Name: \(friendName), Username: \(friendUsername), Song: \(song)\n"
                                    friendDataString += friendDataLine
                                }
                                friendDataText = friendDataString
                                showButton = false // Hide the button after getting user friends
                            }
                        }
                        
                        dataManager.getLastSong(userID: userID) { song in
                            if let song = song {
                                print("[DEBUG] Fetched last uploaded song with name: \(song.name)")
                                self.lastSongName = song.name
                                self.lastSongCoverArt = song.coverArt
                            } else {
                                print("[DEBUG] Error getting last uploaded song")
                            }
                        }
                        
                    }) {
                        Image(systemName: "arrow.clockwise.circle")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 25))
                    }//.opacity(showButton ? 1 : 0) // Hide the button using opacity
                    //.disabled(!showButton) // Disable the button after it's hidden
                    
                    
                    
                    ForEach(friendDataText.split(separator: "\n"), id: \.self) { friendDataLine in
                        if friendDataLine.starts(with: "Name:") {
                            let nameRange = friendDataLine.range(of: "Name: ")!.upperBound..<friendDataLine.range(of: ", Username")!.lowerBound
                            let usernameRange = friendDataLine.range(of: "Username: ")!.upperBound..<friendDataLine.range(of: ", Song")!.lowerBound
                            let songIDRange = friendDataLine.range(of: "Song(id: ")!.upperBound..<friendDataLine.range(of: ", artist")!.lowerBound
                            let artistRange = friendDataLine.range(of: "artist:")!.upperBound..<friendDataLine.range(of: ", name")!.lowerBound
                            let songNameRange = friendDataLine.range(of: ", name: ")!.upperBound..<friendDataLine.range(of: ", coverArt")!.lowerBound
                            let coverArtRange = friendDataLine.range(of: "coverArt: ")!.upperBound..<friendDataLine.range(of: ", album")!.lowerBound
                            let albumNameRange = friendDataLine.range(of: "album: ")!.upperBound..<friendDataLine.endIndex
                            
                            
                            let name = String(friendDataLine[nameRange]).replacingOccurrences(of: "\"", with: "")
                            let username = String(friendDataLine[usernameRange]).replacingOccurrences(of: "\"", with: "")
                            let songID = String(friendDataLine[songIDRange]).replacingOccurrences(of: "\"", with: "")
                            let artist = String(friendDataLine[artistRange]).replacingOccurrences(of: "\"", with: "")
                            let songName = String(friendDataLine[songNameRange]).replacingOccurrences(of: "\"", with: "")
                            let coverArt = String(friendDataLine[coverArtRange]).replacingOccurrences(of: "\"", with: "")
                            let albumName = String(friendDataLine[albumNameRange])
                                .replacingOccurrences(of: "\"", with: "")
                                .replacingOccurrences(of: ")", with: "")

                                VStack {
                                    
                                    Text(name)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .frame(maxWidth: .infinity,alignment: .center)
                                        .font(.custom("Poppins-SemiBold", size: 18))
                                    
                                    Text(username)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxWidth: .infinity,alignment: .center)
                                        .font(.custom("Poppins-Regular", size: 16))

                                    AsyncImage(url: URL(string: coverArt)) { phase in
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
                                    
                                    Text(songName)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(maxWidth: .infinity,alignment: .center)
                                        .font(.custom("Poppins-SemiBold", size: 18))
                                    Text(artist)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                        .frame(maxWidth: .infinity,alignment: .center)
                                        .font(.custom("Poppins-Regular", size: 16))

                                    Spacer()
                                        .frame(height: 10)
                                }
                                .padding(10)
                                .background(Color("RoundRect"))
                                .opacity(0.9)
                                .cornerRadius(10)
                            
                        } else {
                            Text(friendDataLine)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14, weight: .regular))
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    dataManager.fetchCurrentUser { user, error  in
                        if error != nil {
                            print("[DEBUG] Error fetching current user")
                        } else if let user = user {
                            print("[DEBUG] Fetched current user with id: \(user.id)")
                            self.name = dataManager.currentUser.name
                            self.usernm = dataManager.currentUser.username
                            self.userID = dataManager.currentUser.id
                            //                        isLoading = false
                            
                            dataManager.getLastSong(userID: userID) { song in
                                if let song = song {
                                    print("[DEBUG] Fetched last uploaded song with name: \(song.name)")
                                    self.lastSongName = song.name
                                    self.lastSongCoverArt = song.coverArt
                                } else {
                                    print("[DEBUG] Error getting last uploaded song")
                                }
                            }
                        }
                    }

                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


struct FeedEmpty_Previews: PreviewProvider {
    static var previews: some View {
        FeedEmpty()
    }
}
