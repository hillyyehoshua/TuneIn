//
//  ProfileCreationBday.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//

import SwiftUI

struct ProfileCreationBday: View {
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("TuneIn")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 30))
                }
                
                Spacer ()
                    .frame(height: 50)
                
                HStack {
                    Text("Hi Isabella! When's your birthday?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Text("MM")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                    
                    Spacer()
                        .frame(width: 25)
                    
                    Text("DD")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                    
                    Spacer()
                        .frame(width: 25)
                    
                    Text("YYYY")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                }
                
                Spacer()
                
                HStack{
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                }
            }
            
        }
    }
}

struct ProfileCreationBday_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationBday()
    }
}
