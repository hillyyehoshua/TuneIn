//
//  Home.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        ZStack{
            //set background
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (alignment: .center){
                
                Spacer()
                    .frame(height: 250)
                
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
                
                // Sign in request
                HStack{
                    Spacer()
                    //ask user to sign into their spotify
                    Text("Create an account to get started")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 10)
                        .font(.custom("Poppins-Regular", size: 18))
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 20)
                
                NavigationLink(destination: ProfileCreationName()) {
                    // Ask to log in with Spotify
                    Text("Sign up")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 19))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                    
                }
                
                Spacer()
                    .frame(height: 20)
                                                
                HStack {
                    Text("Already have an account?")
                        .font(.custom("Poppins-Regular", size: 14))
                    NavigationLink(destination: LogInNumber()){
                        Text("Log In")
                            .font(.custom("Poppins-SemiBold", size: 14))
                    }
                }
                .foregroundColor(.white)
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)

    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
