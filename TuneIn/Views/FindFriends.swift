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
    @State private var searchreq = ""
    @State private var isAddedDict: [String: Bool] = [:]
    
    
    // MARK: Custom back button code
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        
        HStack {
            Image("right") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
        
        
    }
    }
    // END: Custom back button code
    
    var body: some View {
        

        ZStack {
            
            //set the background
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            
            // MARK: Header and search bar
            VStack {
                // start header
                ZStack {
                    HStack {
                        
                        Text("TuneIn")
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
                        
                        TextField("", text: $searchreq)
                            .modifier(PlaceholderStyle(showPlaceHolder: searchreq.isEmpty, placeholder: "Find friends with good taste          "))
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
                    .frame(height: 10)
                
                // start invite your friends
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 43)
                    
                    HStack{
                        
                        ZStack {
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 30, height: 30)
                            Text(String(name.first!))
                                .font(.custom("Poppins-Regular", size: 16))
                        }
                        .padding(.leading, 35)
                        
                        Text("Invite your friends")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .padding(.leading, 5)
                            .opacity(0.7)
                        
                        Spacer()
                        
                        HStack {
                            Image("upload")
                                .padding(.trailing, 35)
                            
                        }
                        
                    }
                }
                //end invite your friends
                
                Spacer()
                    .frame(height: 35)
                
                // MARK: Friend section
                //Iterate through all of the users in the database
                
                
                //                ScrollView {
                //
                //                    ForEach(dataManager.users, id: \.id) { user in
                //
                //                        let isFriend = dataManager.checkFriendship(friendId: user.id, userId: userID)
                //                            //Group {
                ////                            if let isFriend = $dataManager.checkFriendship(userId: userID, friendId: user.id) {
                //
                //                        if isFriend {
                //
                //                            VStack {
                //
                //                                                    // start profile pic
                //                                                    ZStack {
                //                                                        Circle()
                //                                                            .fill(Color("Blue"))
                //                                                            .frame(width: 50, height: 50)
                //                                                        Text(String(user.name.first!))
                //                                                            .font(.custom("Poppins-Regular", size: 24))
                //                                                    }
                //                                                    // end profile pic
                //
                //                                                    //add space
                //                                                    .padding(.leading, 20)
                //
                //                                                    VStack(alignment: .leading) {
                //                                                        if user.name != name {
                //                                                            Text(user.name)
                //                                                                .foregroundColor(.white)
                //                                                                .font(.custom("Poppins-SemiBold", size: 16))
                //
                //                                                            Text(user.username)
                //                                                                .foregroundColor(.white)
                //                                                                .font(.custom("Poppins-Regular", size: 12))
                //                                                        }
                //                                                    }
                //
                //                                                    Spacer()
                //
                //                                                    let _ = print ("This is user.id: (friends) \(user.id)")
                //                                                    let _ = print ("This is my ID: (me) \(userID)")
                //
                //                                                    ZStack {
                //                                                        RoundedRectangle(cornerRadius: 15)
                //                                                            .fill(.white)
                //                                                            .opacity(0.1)
                //                                                            .frame(width: 60, height: 30)
                //
                //                                                        Button(action: {
                //                                                            if let isAdded = isAddedDict[user.id] {
                //                                                                isAddedDict[user.id] = !isAdded
                //                                                            } else {
                //                                                                isAddedDict[user.id] = true
                //                                                            }
                //                                                            dataManager.addFriendToUser(userId: userID, friendId: "36Vvz7Cp2ZKytxZjbwxs")
                //                                                        }) {
                //                                                            if let isAdded = isAddedDict[user.id], isAdded {
                //                                                                Text("Added")
                //                                                                    .foregroundColor(.white)
                //                                                                    .font(.custom("Poppins-SemiBold", size: 14))
                //                                                            } else {
                //                                                                Text("Add")
                //                                                                    .foregroundColor(.white)
                //                                                                    .font(.custom("Poppins-SemiBold", size: 14))
                //                                                            }
                //                                                        }
                //
                //
                //                                                    }
                //
                //                                            }
                //                                        }
                //                                    //}
                //                        }
                //                        Spacer()
                //
                //
                //                }
                
                //TODO: There is a bug here where the if the database of users are empty, it crashes
                ScrollView {
                    ForEach(dataManager.users, id: \._id) { user in
                        // start friend card
                        HStack {
                            // start profile pic
                            ZStack {
                                Circle()
                                    .fill(Color("Blue"))
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
                                    if let isAdded = isAddedDict[user._id] {
                                        isAddedDict[user._id] = !isAdded
                                    } else {
                                        isAddedDict[user._id] = true
                                    }
                                    dataManager.addFriendToUser(userId: userID, friendId: user._id)
                                }) {
                                    if let isAdded = isAddedDict[user._id], isAdded {
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
}

struct FindFriends_Previews: PreviewProvider {
    static var previews: some View {
        FindFriends(name: .constant("john"), usernm: .constant("johnny"), userID: .constant("uniqueid"))
            .environmentObject(DataManager())
    }
}
