//
//  ProfileCreationName.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/27/23.
//

import SwiftUI

struct ProfileCreationName: View {
    
    @State private var name = ""
    
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
                
                HStack(alignment: .center) {
                    TextField("", text: $name)
                        .modifier(PlaceholderStyle(showPlaceHolder: name.isEmpty, placeholder: "Your Name"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                }
                .frame(alignment: .center)
                .foregroundColor(.white)
                
                Spacer()
                
                if (name.isEmpty){
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                }else{
                    NavigationLink(destination: ProfileCreationUserNM(name: $name)){
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
            .frame(alignment: .center)

        }
        
//        ProfileCreationTimeZone(name: $name)
        
    }
}
    
public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            if showPlaceHolder {
                Text(placeholder)
                    .opacity(0.5)
            }
            content
            .foregroundColor(Color.white)
        }
    }
}


struct ProfileCreationName_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationName()
    }
}
    
