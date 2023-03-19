//
//  FindFriends.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct FindFriends: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // start header
                ZStack {
                    
                    HStack {
                        Text("TuneIn")
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image("right")
                            .frame(alignment: .trailing)
                            .padding(.trailing, 20)
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
                        
                        Text("Find friends with good taste")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .padding(.leading, 5)
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
                            Text("H")
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
                
                Spacer()
                    .frame(height: 35)
                
                //Iterate through all of the users in the database
                ForEach (dataManager.users, id: \.id) { user in
                    // start friend card
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 50, height: 50)
                            Text("L")
                                .font(.custom("Poppins-Regular", size: 24))
                        }
                        .padding(.leading, 20)
                        
                        VStack (alignment: .leading) {
                            Text (user.name)
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                            
                            Text(user.username)
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 12))
                        }
                        
                        Spacer()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .opacity(0.1)
                                .frame(width: 60, height: 30)
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 14))
                        }
                        .padding(.trailing, 20)
                    }
                    // end friend card
                    
                }
                    
                //}
                
                
                
                
                
                
                
//                FriendCard()
//
//                FriendCard()
//
//                FriendCard()
                
                Spacer()
            }
            
        }//.navigationBarBackButtonHidden(true)
    }
}

struct FindFriends_Previews: PreviewProvider {
    static var previews: some View {
        FindFriends()
            .environmentObject(DataManager())
    }
}
