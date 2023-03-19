//
//  SwiftUIView.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/25/23.
//

import SwiftUI

struct SwiftUIView: View {
        
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // heading
                ZStack {
                    HStack {
                        Image("Close")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-SemiBold", size: 20))
                        Image("Check")
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .padding(.trailing, 20)
                    }
                }
                // end heading
                
                // profile image
                ZStack{
                    Circle()
                        .fill(Color("Blue"))
                        .frame(width: 100, height: 100)
                    Text("H")
                        .font(.custom("Poppins-Regular", size: 50))
                }
                // end profile image
                
                Spacer()
                    .frame(height: 35)
                
                // "Full Name" Card
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 43)
                    HStack{
                        Text("Name")
                            .frame(alignment: .leading)
                            .padding(.leading, 35)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("Hilly Yehoshua")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 14))
                        
                    }
                    .padding(.trailing, 35.0)
                }
                // end "Full Name" Card
                
                Spacer()
                    .frame(height: 10)

                // "Username" Card
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 43)
                    HStack{
                        Text("Birthday")
                            .frame(alignment: .leading)
                            .padding(.leading, 35)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .padding(.leading, 5)
                        
                        
                        Spacer()
                        
                        Text("09/10/2000")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 14))
                        
                    }
                    .padding(.trailing, 35.0)
                }
                // end "Username" Card
                
                Spacer()
                    .frame(height: 10)
                
                // "Spotify" Card
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 43)
                    HStack{
                        Text("Phone number")
                            .frame(alignment: .leading)
                            .padding(.leading, 35)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("850-766-6888")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 14))
                        
                    }
                    .padding(.trailing, 35.0)
                }
                // end "Spotify" Card
                
                Spacer()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
