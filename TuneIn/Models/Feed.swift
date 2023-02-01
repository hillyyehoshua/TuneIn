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
            VStack{
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

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
