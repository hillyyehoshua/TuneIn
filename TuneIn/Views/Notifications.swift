//
//  Notifications.swift
//  TuneIn
//
//  Created by Izzy Hood on 2/1/23.
//

import SwiftUI

struct Notifications: View {
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // heading
                ZStack{
                    HStack {
                        Image("left")
                            .frame(alignment: .leading)
                            .padding(.leading,  20)
                        Spacer()
                    }
                    HStack {
                        Text("Notifications")
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 20))
                    }
                }
                // end heading
                
                Spacer()
                    .frame(height: 15)
                
                Text("On TuneIn, you are in control of your push notification. Choose what you want to receive. ")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Regular", size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.leading, 35)
                    .padding(.trailing, 35)
                
                Spacer()
                    .frame(height: 20)
                
                Group{
                    
                    // start Mentions
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("At sign")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Mentions")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Spacer()
                            
                        }
                    }
                    // end Mentions
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // start Comments
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Topic")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Comments")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Spacer()
                            
                        }
                    }
                    // end Comments
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // start Friend Requests
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Team")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Friend Requests")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Spacer()
                            
                        }
                    }
                    // end Friend Requests
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // start Late Song Upload
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                            .opacity(0.1)
                            .frame(width: 348, height: 43)
                        HStack{
                            Image("Clock")
                                .frame(width: 25, height: 25, alignment: .leading)
                                .padding(.leading, 35)
                            
                            Text("Late Song Upload")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Spacer()
                            
                        }
                    }
                    // end Late Song Upload
                }
                    
                Spacer()
            }
            
        }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
