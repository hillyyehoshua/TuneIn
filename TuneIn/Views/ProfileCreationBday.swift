//
//  ProfileCreationBday.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//

import SwiftUI

struct ProfileCreationBday: View {
    @State private var bdaymonth: String = ""
    @State private var bdayday: String = ""
    @State private var bdayyear: String = ""

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
                    
                        
                    TextField("MM", text: $bdaymonth)
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
//                    Text ("")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//                        .multilineTextAlignment(.center)
//                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    TextField("DD", text: $bdayday)
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
//                    Text ("")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//                        .multilineTextAlignment(.center)
//                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                    TextField("YYYY", text: $bdayyear)
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                        .opacity(0.5)
                        .multilineTextAlignment(.center)
                  
//                    Spacer()
//                        .padding(.leading, 20)
//                        .padding(.trailing, 20)
//                    Text("MM")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//
//                    Spacer()
//                        .frame(width: 25)
//
//                    Text("DD")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
//
//                    Spacer()
//                        .frame(width: 25)
//
//                    Text("YYYY")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 36))
//                        .opacity(0.5)
                }
                
                Spacer()
                NavigationLink(destination: ProfileCreationNumber()){
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

struct ProfileCreationBday_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationBday()
    }
}
