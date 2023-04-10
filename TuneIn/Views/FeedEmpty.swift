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
    
    var body: some View {
        
        ZStack{
            //App background color
            let _ = print ("user ID in feed empty \(String(describing: $userID))")
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
                    //.frame(maxWidth: .infinity, alignment: .leading)
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
                           }) {
                               Text("Get User Friends")
                                   .foregroundColor(.white)
                                   .font(.system(size: 20, weight: .bold))
                                   .padding(.horizontal, 10)
                                   .padding(.vertical, 5)
                                   .background(Color.blue)
                                   .cornerRadius(10)
                           }.opacity(showButton ? 1 : 0) // Hide the button using opacity
                        .disabled(!showButton) // Disable the button after it's hidden



                    ForEach(friendDataText.split(separator: "\n"), id: \.self) { friendDataLine in
                        if friendDataLine.starts(with: "Name:") {
                            let nameRange = friendDataLine.range(of: "Name: ")!.upperBound..<friendDataLine.range(of: ", Username")!.lowerBound
                            let usernameRange = friendDataLine.range(of: "Username: ")!.upperBound..<friendDataLine.range(of: ", Song")!.lowerBound
                            let songIDRange = friendDataLine.range(of: "Song(id: ")!.upperBound..<friendDataLine.range(of: ", artist")!.lowerBound
                            let artistRange = friendDataLine.range(of: "artist:")!.upperBound..<friendDataLine.range(of: ", name")!.lowerBound

                            let name = String(friendDataLine[nameRange])
                            let username = String(friendDataLine[usernameRange])
                            let songID = String(friendDataLine[songIDRange])
                            let artist = String(friendDataLine[artistRange])

                            VStack {
                                Text(name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                                Text(username)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                Text(songID)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                Text(artist)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .padding(10)
                            .background(Color.pink)
                            .cornerRadius(10)
                        } else {
                            Text(friendDataLine)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 14, weight: .regular))
                        }
                    }

//                            ForEach(friendDataText.split(separator: "\n"), id: \.self) { friendDataLine in
//                                if friendDataLine.starts(with: "Name:") {
//                                    Text(friendDataLine)
//                                        .foregroundColor(.white)
//                                        .padding(10)
//                                        .background(Color.pink)
//                                        .cornerRadius(10)
//                                } else {
//                                    Text(friendDataLine)
//                                        .foregroundColor(.white)
//                                        .multilineTextAlignment(.leading)
//                                        .font(.system(size: 14, weight: .regular))
//                                }
//
//
//                            }
                        
                    
                       }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.immediately)
                //            }
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    dataManager.fetchCurrentUser { user, error  in
                        if error != nil {
                            print("Error fetching current user")
                        } else if let user = user {
                            print("Fetched current user with id: \(user.id)")
                            self.name = dataManager.currentUser.name
                            self.usernm = dataManager.currentUser.username
                            self.userID = dataManager.currentUser.id
                            //                        isLoading = false
                        }
                    }
                }
            }
            //        .onChange(of: scenePhase) { newPhase in
            //            if newPhase == .active {
            //                if Auth.auth().currentUser != nil {
            //                    dataManager.fetchCurrentUser { user, error  in
            //                        if error != nil {
            //                            print("Error fetching current user")
            //                        } else if let user = user {
            //                            print("Fetched current user with id: \(user.id)")
            //                            self.name = dataManager.currentUser.name
            //                            self.usernm = dataManager.currentUser.username
            //                            self.userID = dataManager.currentUser.id
            //                            isLoading = false
            //                        }
            //                    }
            //                }
            //            }
            //        }
            
        }
    }
    
    //Playlist with today's songs
    struct Empty: View {
        @Binding var name: String
        @Binding var usernm: String
        @Binding var userID: String
        
        var body: some View {
            VStack (spacing: 1){
                // WAS: NavigationLink(destination: UploadSongView(name: $name, usernm: $usernm, userID: $userID)){
                NavigationLink(destination: SongSearchListView(name: $name, userID: $userID, songs: [])){
                    Image("plus")
                        .resizable()
                        .frame(width: 172, height: 172)
                }
                
                
                NavigationLink(destination: SongSearchListView(name: $name, userID: $userID, songs: [])){
                    Text("Add Monday's Song")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .font(.custom("Poppins-SemiBold", size: 18))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                }
                
                Spacer()
                    .frame(height: 100)
                
                NavigationLink(destination: FindFriends(name: $name, usernm: $usernm, userID: $userID)){
                    HStack{
                        Text("Find Friends")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 20))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 230, height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                    }
                }
                .navigationBarBackButtonHidden(true)
                
                
                
                
            }
            
            
        }
        
    }
}

struct FeedEmpty_Previews: PreviewProvider {
    static var previews: some View {
        FeedEmpty()
    }
}
