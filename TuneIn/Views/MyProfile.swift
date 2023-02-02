//
//  MyProfile.swift
//  TuneIn
//
//  Created by Izzy Hood on 2/1/23.
//

import SwiftUI

struct MyProfile: View {
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // heading
                ZStack {
                    HStack {
                        Image("left")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)

                        Spacer()
                        
                        Image("Settings")
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .padding(.trailing, 20)
                    }
                }
                // end heading
                
                Spacer()
                    .frame(height: 20)
                
                // begin album meta image
                VStack {
                    HStack {
                        Image("image 1")
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        Spacer()
                            .frame(width: 0)
                        
                        Image("image 3")
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                    }
                    
                    Spacer()
                        .frame(height: 0)
                    
                    HStack {
                        Image("image 5")
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                        Spacer()
                            .frame(width: 0)
                        
                        Image("image 10")
                            .resizable()
                            .frame(width: 120, height: 120)
                        
                    }
                }
                // end album meta image
                
                Spacer()
                    .frame(height: 20)
                
                // begin heading
                HStack{
                    VStack{
                        Text("Your Library")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 26))
                        
                        Spacer()
                            .frame(height: 5)
                        
                        HStack{
                            ZStack {
                                Circle()
                                    .fill(Color("Blue"))
                                    .frame(width: 24, height: 24)
                                Text("H")
                                    .font(.custom("Poppins-Regular", size: 14))
                            }
                        
                        
                            Text("Hilly Yehoshua")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .opacity(0.7)
                        }
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    Image("link 2")
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 20)
                }
                // end heading
                
                
                
                Spacer()
            }
        }
    }
}

struct MyProfile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile()
    }
}
