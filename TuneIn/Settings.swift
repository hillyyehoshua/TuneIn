//
//  Settings.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack{
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack{
                    HStack {
                        Image("left")
                            .frame(alignment: .leading)
                            .padding(.leading,  20)
                        Spacer()
                    }
                    HStack {
                        Text("Settings")
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                    
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 74)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 52, height: 52)
                            Text("H")
                                .font(.custom("Poppins-Regular", size: 25))
                        }
                        .padding(.leading, 35)
                        VStack (alignment: .leading){
                            Text("Hilly Yehoshua")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Text("hilly_y29")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 5)
                        }
                        Spacer()
                        HStack {
                            Image("right")
                                .frame(alignment: .trailing)
                        }
                        .padding(.trailing, 35)
                    }
                }
                
                Spacer()
                    .frame(height: 35)
                
                Group{
                    // "Your Library" card
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Library")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Your Library")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .padding(.leading, 5)
                            
                            Spacer()
                            
                            HStack{
                                Image("right")
                                    .frame(alignment: .trailing)
                            }
                            .padding(.trailing, 35)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // "Notifcations" Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Alarm")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Notifications")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .padding(.leading, 5)
                            
                            Spacer()
                            
                            HStack{
                                Image("right")
                                    .frame(alignment: .trailing)
                            }
                            .padding(.trailing, 35)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // "Time Zone" Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Globe")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Time Zone")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .padding(.leading, 5)
                            
                            Spacer()
                            
                            HStack{
                                Image("right")
                                    .frame(alignment: .trailing)
                            }
                            .padding(.trailing, 35)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // "Contact Us" Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Envelope")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Contact Us")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .padding(.leading, 5)
                            
                            Spacer()
                            
                            HStack{
                                Image("right")
                                    .frame(alignment: .trailing)
                            }
                            .padding(.trailing, 35)
                        }
                    }
                }
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 52)
                    Text("Log Out")
                        .foregroundColor(.red)
                        .font(.custom("Poppins-SemiBold", size: 18))
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
