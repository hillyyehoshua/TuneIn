//
//  FeedEmpty.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 2/16/23.
//

import SwiftUI

struct FeedEmpty: View {
    @Binding var name: String
    @Binding var usernm: String
    
    var body: some View {
        ZStack{
            //App background color
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 17){
                //Header that does not move
                HStack{
                    //Add friends
                    NavigationLink(destination: FindFriends(name: $name, usernm: $usernm)){
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
                    NavigationLink(destination: Settings(name: $name, usernm: $usernm)){
//                        Image("HProfile")
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 40, height: 40)
//                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
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
                    
                    //playlist with all of your friends tunes; if you haven't uploaded a song its your add song button
                    
                    Empty(name: $name, usernm: $usernm)
                    
                    //ideally would have parameters for this instead of isabella hood each time but we can fix later
                    
//                    SongCard()
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
//                    SongCard()
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            
        }
       
    }
}

//Playlist with today's songs
struct Empty: View {
    @Binding var name: String
    @Binding var usernm: String
    var body: some View {
        VStack (spacing: 1){
            Image("plus")
                .resizable()
                .frame(width: 172, height: 172)
            NavigationLink(destination: Feed(name: $name, usernm: $usernm)){
                Text("Add Monday's Song")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            }
            
//            HStack{
//                Image("heart")
//                    .resizable()
//                    .clipShape(Circle())
//                    .frame(width: 15, height: 15)
//                    .padding(EdgeInsets(top: 0, leading: 120, bottom: 0, trailing: 0))
//                    .frame(maxWidth: .infinity,alignment: .center)
//                    
//                Text("Your Friends")
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: 0))
//                    .font(.custom("Poppins-Regular", size: 13))
//                    
//            }
            Spacer()
                .frame(height: 100)
            NavigationLink(destination: FindFriends(name: $name, usernm: $usernm)){
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

struct FeedEmpty_Previews: PreviewProvider {
    static var previews: some View {
        FeedEmpty(name: .constant("John Doe"), usernm: .constant("username"))
    }
}
