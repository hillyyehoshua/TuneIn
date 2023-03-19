//
//  ProfileCreationNumber.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//

import SwiftUI

struct ProfileCreationNumber: View {
    
    @State private var phoneNumber = ""
    
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
                    .frame(height: 45)
                
                HStack {
                    Text("What's your phone number?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 5)
                
                
                HStack {
                    Text("This is how we will create your account.")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .opacity(0.8)
                }
                    
                Spacer()
                        .frame(height: 20)
                
                HStack(alignment: .center) {
                    TextField("", text: $phoneNumber)
                        .modifier(PlaceholderStyle(showPlaceHolder: phoneNumber.isEmpty, placeholder: "XXX  XXX  XXXX"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                }
                .frame(alignment: .center)
                .foregroundColor(.white)
                
                    
                Spacer()
                    
                NavigationLink(destination: ProfileCreationTimeZone()){
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


struct ProfileCreationNumber_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationNumber()
    }
}
