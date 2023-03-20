//
//  Feed.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/31/23.
//

import SwiftUI

struct Feed: View {
    
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
                    
                    //TODO: Add logic of if photo then display, if not show first letter of name
                    //Add user's profile picture / image
                    NavigationLink(destination: Settings(name: $name, usernm: $usernm)){
                        Image("HProfile")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    }
                    
                        
                }
                
                //Scroll and see all of peoples' posts
                ScrollView {
                    
                    //playlist with all of your friends tunes; if you haven't uploaded a song its your add song button
                    TodayTune()
                    
                    //ideally would have parameters for this instead of isabella hood each time but we can fix later
                    
                    SongCard()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    SongCard()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

//Playlist with today's songs
struct TodayTune: View {
    var body: some View {
        VStack (spacing: 1){
            Image("todaysongs")
                .resizable()
                .frame(width: 172, height: 172)
            Text("Monday's Tunes")
                .foregroundColor(.white)
                //.frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxWidth: .infinity,alignment: .center)
                .font(.custom("Poppins-SemiBold", size: 18))
            HStack{
                Image("heart")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 15, height: 15)
                    .padding(EdgeInsets(top: 0, leading: 120, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity,alignment: .center)
                    
                Text("Your Friends")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: 0))
                    .font(.custom("Poppins-Regular", size: 13))
                    
            }
            
        }
        
    }
    
}


struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed(name: .constant("John Doe"), usernm: .constant("username"))
    }
}

struct TodayTune_Previews: PreviewProvider {
    static var previews: some View {
        TodayTune()
    }
}
