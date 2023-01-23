//
//  ContentView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

// Structure for the view that manages primary app screens and navigation.
struct ContentView: View {
    var body: some View {
        ZStack{
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack (alignment: .center){
                HStack{
                    Text("TuneIn")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 58))
                    Image(systemName:"play.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top, 25)
                }
                Spacer()
                    .frame(height: 30)
                HStack{
                    Spacer()
                    Text("Get Started by signing into your Spotify Account")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 15)
                        .font(.custom("Poppins-Regular", size: 20))
                    Spacer()
                }
                Spacer()
                    .frame(height: 22)
                
                Text("Log In with Spotify")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Regular", size: 18))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(width: 210, height: 45)
                    .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                
                    
                
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
