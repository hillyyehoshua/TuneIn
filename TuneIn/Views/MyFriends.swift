//
//  MyFriends.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/22/23.
//

import SwiftUI

struct MyFriends: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var name: String
    @Binding var usernm: String
    @Binding var userID: String
    @State var isLoading = true
    @State private var searchreq = ""
    @State private var searchQuery = ""
    @State private var friends: [Dictionary<String, String>] = []
    @State private var isRemovedDict: [String: Bool] = [:]
    @State private var isRemoved = false

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
    // END: Custom back button code
    
    var filteredFriends: [Dictionary<String, String>] {
        if searchQuery.isEmpty {
            return friends
        } else {
            return friends.filter { friend in
                let name = friend["name"] ?? ""
                let username = friend["username"] ?? ""
                return name.localizedCaseInsensitiveContains(searchQuery) || username.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    var body: some View {
        ZStack {
            //set the background
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            } else {
                // MARK: Header and search bar
                VStack {
                    // start header
                    ZStack {
                        HStack {
                            
                            Text("Your friends")
                                .frame(alignment: .center)
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 30))
                        }
                    }
                    // end header
                    
                    // start search bar
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack {
                            Image("search")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 5)
                            
                            Spacer()
                                .frame(width: 15)
                            
                            TextField("", text: $searchQuery)
                                .modifier(PlaceholderStyle(showPlaceHolder: searchQuery.isEmpty, placeholder: "Search your friends"))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .opacity(0.7)
                                .padding(.leading, -150) // add negative padding to align text with icon
                            
                            Spacer()
                        }
                        .padding(.leading, 25)

//                        HStack{
//                            Image("search")
//                                .frame(width: 25, height: 25, alignment: .leading)
//                                .padding(.leading, 5)
//
//                            Spacer()
//                                .frame(width: 15)
//
//                            TextField("", text: $searchQuery)
//                                .modifier(PlaceholderStyle(showPlaceHolder: searchQuery.isEmpty, placeholder: "Search your friends"))
//                                .multilineTextAlignment(.leading)
//                                .foregroundColor(.white)
//                                .accentColor(.white)
//                                .font(.custom("Poppins-Regular", size: 16))
//                                .opacity(0.7)
//
//                            Spacer()
//                        }
//                        .padding(.leading, 25)
                    }
                    // end search bar
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Spacer()
                        .frame(height: 35)
                    
                    // MARK: Friend section
                    ScrollView {
                        
                        ForEach(filteredFriends, id: \.self) { friendDict in
                                
                            let friendID = friendDict["id"] ?? ""
                            let friendName = friendDict["name"] ?? ""
                            let friendUsername = friendDict["username"] ?? ""
    //                            let friendID = "placeholder"
    //                            let friendName = "placeholder"
    //                            let friendUsername = "placeholder"
                                
                            HStack{
                                let colors = [Color.blue, Color.green, Color.pink, Color.yellow, Color.teal, Color.purple, Color.red]
                                ZStack {
                                    Circle()
                                        .fill(colors.randomElement()!)
                                        .frame(width: 50, height: 50)
                                    Text(String(friendName.prefix(1)))
                                        .font(.custom("Poppins-Regular", size: 24))
                                }.padding(.leading, 10)
                                
                                VStack(alignment: .leading){
                                    Text(friendName)
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                    Text(friendUsername)
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Regular", size: 12))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    isRemovedDict[friendID, default: false] = !isRemovedDict[friendID, default: false]
                                    dataManager.removeFriendFromUser(userid: userID, friendid: friendID)
                                }) {
                                    ZStack {
                                         RoundedRectangle(cornerRadius: 15)
                                            .fill(isRemovedDict[String(friendID), default: false] ? Color.green.opacity(0.8) : Color.white.opacity(0.1))
                                             .frame(width: 80, height: 30)
                                        Text(isRemovedDict[String(friendID), default: false] ? "Removed" : "Remove")
                                             .foregroundColor(.white)
                                             .font(.custom("Poppins-SemiBold", size: 14))
                                     }
                                }
                                .padding()
                            }
                        }
                    }
                }
                Spacer()
            }

        }
        .onAppear {
            dataManager.getUserFriends(userID: userID) { friends, error in
                if let error = error {
                    print("[DEBUG] Error retrieving friends list: \(error.localizedDescription)")
                } else if let friends = friends {
                    self.friends = friends
                    print(self.friends)
                    isLoading = false
                } else {
                    print("[DEBUG] No friends found.")
                }
            }

        }
        // Enables Custom back button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        }
    }

struct MyFriends_Previews: PreviewProvider {
    static var previews: some View {
        MyFriends(name: .constant("john dope"), usernm: .constant("joey"), userID: .constant("UNIQUEID"))
    }
}
