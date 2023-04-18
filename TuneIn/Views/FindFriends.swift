//
//  FindFriends.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct FindFriends: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var name: String
    @Binding var usernm: String
    @Binding var userID: String
    @State var isLoading = true
    @State private var friends: [Dictionary<String, String>] = []
    @State private var searchreq = ""
    @State private var searchQuery = ""
    @State private var isAddedDict: [String: Bool] = [:]
    
    
    
    // MARK: Custom back button code
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    })
        {
        
            HStack {
                Image("right") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        }
    }
    // END: Custom back button code
    
    var filteredUsers: [User] {
        if searchQuery.isEmpty {
            return dataManager.users
        } else {
            return dataManager.users.filter { user in
                let nameMatch = user.name.localizedCaseInsensitiveContains(searchQuery)
                let usernameMatch = user.username.localizedCaseInsensitiveContains(searchQuery)
                let isFriend = friends.contains(where: { $0["id"] == user.id })
                return (nameMatch || usernameMatch) && !isFriend
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
                            Text("Find friends")
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
                        HStack{
                            Image("search")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            TextField("", text: $searchQuery)
                                .modifier(PlaceholderStyle(showPlaceHolder: searchQuery.isEmpty, placeholder: "Find friends with good taste          "))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                                .accentColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .opacity(0.7)
                            
                            Spacer()
                        }
                    }
                    // end search bar
                    
                    Spacer()
                        .frame(height: 35)
                    
                    //TODO: There is a bug here where the if the database of users are empty, it crashes
                    ScrollView {
                        ForEach(filteredUsers, id: \.id) { user in
                            // start friend card
                            HStack {
                                
                                let colors = [Color.blue, Color.green, Color.pink, Color.yellow, Color.teal, Color.purple, Color.red]
                                
                                // start profile pic
                                ZStack {
                                    Circle()
                                        .fill(colors.randomElement()!)
                                        .frame(width: 50, height: 50)
                                    Text(String(user.name.first!))
                                        .font(.custom("Poppins-Regular", size: 24))
                                }
                                // end profile pic
                                
                                //add space
                                .padding(.leading, 20)
                                
                                VStack(alignment: .leading) {
                                    if user.name != name {
                                        Text(user.name)
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                        
                                        Text(user.username)
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Regular", size: 12))
                                    }
                                }
                                
                                Spacer()
                                
                                let _ = print ("This is user.id: (friends) \(user.id)")
                                let _ = print ("This is my ID: (me) \(userID)")
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .opacity(0.1)
                                        .frame(width: 60, height: 30)
                                    
                                    Button(action: {
                                        if let isAdded = isAddedDict[user.id] {
                                            isAddedDict[user.id] = !isAdded
                                        } else {
                                            isAddedDict[user.id] = true
                                        }
                                        dataManager.addFriendToUser(userId: userID, friendId: user.id)
                                    }) {
                                        if let isAdded = isAddedDict[user.id], isAdded {
                                            Text("Added")
                                                .foregroundColor(.white)
                                                .font(.custom("Poppins-SemiBold", size: 14))
                                                .padding()
                                        } else {
                                            Text("Add")
                                                .foregroundColor(.white)
                                                .font(.custom("Poppins-SemiBold", size: 14))
                                                .padding()
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                }
                
                // Enables Custom back button
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: btnBack)
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
    }
}

struct FindFriends_Previews: PreviewProvider {
    static var previews: some View {
        FindFriends(name: .constant("john"), usernm: .constant("johnny"), userID: .constant("uniqueid"))
            .environmentObject(DataManager())
    }
}
