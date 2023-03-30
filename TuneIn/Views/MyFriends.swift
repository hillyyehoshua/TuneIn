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
    @State private var searchreq = ""
    @State private var friends: [String] = []
    @State private var isAddedDict: [String: Bool] = [:]
    @State private var isRemoved = false

    
    
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
                            .modifier(PlaceholderStyle(showPlaceHolder: searchreq.isEmpty, placeholder: "Look at your friend list!          "))
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
                        
//                        ZStack {
//                            Circle()
//                                .fill(Color("Blue"))
//                                .frame(width: 30, height: 30)
//                            Text(String(name.first!))
//                                .font(.custom("Poppins-Regular", size: 16))
//                        }
//                        .padding(.leading, 35)
                        
                        Text("         Invite your friends to join the app!")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .padding(.leading, 5)
                            .opacity(0.7)
                            //.background(Rectangle().fill(Color.white).shadow(radius: 5))
                        
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
                
                
                
                
                ScrollView {
                    
                        ForEach(friends, id: \.self) { friendID in
                            HStack{
                                ZStack {
                                    Circle()
                                        .fill(Color("Blue"))
                                        .frame(width: 50, height: 50)
                                    Text(String(friendID.first!))
                                        .font(.custom("Poppins-Regular", size: 24))
                                }.padding(.leading, 10)
                                VStack{
                                    Text(friendID)
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-SemiBold", size: 16))
                                    Text("username")
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Regular", size: 12))
                                }
                                Spacer()
                                

                                
//                                ZStack{
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .fill(.white)
//                                        .opacity(0.1)
//                                        .frame(width: 80, height: 30)
//                                    Text("Remove")
//                                        .foregroundColor(.white)
//                                        .font(.custom("Poppins-SemiBold", size: 14))
//                                }.padding()
                                
                                Button(action: {
                                    isRemoved.toggle()
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(isRemoved ? Color.green.opacity(0.8) : Color.white.opacity(0.1))
                                            .frame(width: 80, height: 30)
                                        Text(isRemoved ? "Removed" : "Remove")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-SemiBold", size: 14))
                                    }
                                }.padding()
                            }


                        }
                    }.onAppear {
                        dataManager.getUserFriends(userID: userID) { friends, error in
                            if let error = error {
                                print("Error retrieving friends list: \(error.localizedDescription)")
                            } else if let friends = friends {
                                self.friends = friends
                            } else {
                                print("No friends found.")
                            }
                        }
                    }
                Spacer()

                    
                }
                
                // Enables Custom back button
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: btnBack)
            }
        }
    }

struct MyFriends_Previews: PreviewProvider {
    static var previews: some View {
        MyFriends(name: .constant("john dope"), usernm: .constant("joey"), userID: .constant("UNIQUEID"))
    }
}
