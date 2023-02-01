//
//  Feed.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/31/23.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ZStack{
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 17){
                HStack{
                    Image(systemName: "person.2.fill")
                        .foregroundColor(Color(.white))
                        .font(.system(size: 25))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))

                    Text("TuneIn")
                        .foregroundColor(.white)
                        //.frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxWidth: .infinity,alignment: .center)
                        .font(.custom("Poppins-SemiBold", size: 32))
                    Image("HProfile")
                        .resizable()
                        
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                }
                ScrollView {
                    TodayTune()
                    SongCard()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    SongCard()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }
                
            }
            
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.immediately)
            
        }
       
    }
}

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
        Feed()
    }
}

struct TodayTune_Previews: PreviewProvider {
    static var previews: some View {
        TodayTune()
    }
}
