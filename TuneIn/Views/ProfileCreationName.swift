//
//  ProfileCreationName.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/27/23.
//

import SwiftUI

struct ProfileCreationName: View {
    @State private var nameuser: String = ""
    
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
                    Text("Welcome! What's your name?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                VStack(alignment: .center){

                        TextField("Your name", text: $nameuser)
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 36))
                            .opacity(0.5)
                            .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                NavigationLink(destination: ProfileCreationBday()){
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
}

struct ProfileCreationName_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationName()
    }
}
