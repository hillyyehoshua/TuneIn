//
//  LogIn.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct LogIn: View {
    var body: some View {
        ZStack{
            //set background
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (alignment: .center){
                
                // Logo
                HStack{
                    Text("TuneIn")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 58))
                    //add the play button
                    Image(systemName:"play.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top, 25)
                }
                
                Spacer()
                    .frame(height: 40)
                
                // Sign in request
                HStack{
                    Spacer()
                    //ask user to sign into their spotify
                    Text("Get Started by signing into your Spotify Account")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 10)
                        .font(.custom("Poppins-Regular", size: 19))
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 26)
                
                
                                    // Ask to log in with Spotify
                                    Text("Log In with Spotify")
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Regular", size: 19))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: 230, height: 50)
                                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                    
                    
                    
                }
                .padding()
            }
        }
    }


struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
