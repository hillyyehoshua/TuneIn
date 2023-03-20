//
//  SongCar.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/31/23.
//

import SwiftUI

struct SongCard: View {
    var body: some View {
        //1c293f
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("RoundRect"))
                .opacity(0.9)
                .frame(width: 330, height: 425)
            VStack{
                //Make the profile and name
                HStack (alignment: .bottom){
                    Image("corgi")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding(.leading, 50)
                    VStack{
                        Text("Isabella Hood")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-SemiBold", size: 16))
                        Text("3 hrs late")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                }
                // Add the song cover
                Image("lovestory")
                    .resizable()
                    .frame(width: 309, height: 309)
                    .padding(EdgeInsets(top: -25, leading: 0, bottom: 5, trailing: 0))
                    .cornerRadius(5)
                //song name
                Text("Love Story (Taylor's Version)")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: -5, leading: 45, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity,alignment: .center)
                    .font(.custom("Poppins-SemiBold", size: 18))
                //artist
                Text("Taylor Swift")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 45, bottom: 5, trailing: 0))
                    //.padding(.trailing, 100)
                    //.multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .font(.custom("Poppins-Regular", size: 16))
            }
            

        }
        
            
    }
}

struct SongCard_Previews: PreviewProvider {
    static var previews: some View {
        SongCard()
    }
}

