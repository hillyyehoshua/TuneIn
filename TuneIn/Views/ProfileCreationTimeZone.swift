//
//  ProfileCreationTimeZone.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 2/16/23.
//

import SwiftUI

struct ProfileCreationTimeZone: View {
    @State private var selection = 1
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
                    Text("Where do you live?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 5)
                
                    HStack (spacing: 30) {
                        Spacer()
                        Text("Knowing your time zone allows us to send you notifications at the right time!")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .opacity(0.8)
                        Spacer()
                    }
                
                
                    
                Spacer()
                        .frame(height: 20)
                    
                ZStack (alignment: .top){
                    
//                    RoundedRectangle(cornerRadius: 5)
//                        .fill(.white)
//                        .frame(width: 230, height: 30)
                    
                    Picker(selection: $selection, label: Text("Pick a time zone")) {
                        Text("America").tag(1)
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                        Text("Europe").tag(2)
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                        Text("East Asia").tag(3)
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                        Text("West Asia").tag(4)
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                }
                
                    
                //.rectangle
//                HStack {
//                    Text("XXX")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//
//                    Spacer()
//                        .frame(width: 25)
//
//                    Text("XXX")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//
//                    Spacer()
//                        .frame(width: 25)
//
//                    Text("XXXX")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//                }
                    
                Spacer()
                NavigationLink(destination: FeedEmpty()){
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

struct ProfileCreationTimeZone_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationTimeZone()
    }
}
