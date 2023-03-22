//
//  ProfileCreationUserNM.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/19/23.
//

import SwiftUI

struct ProfileCreationUserNM: View {
    @Binding var name: String
    @State private var usernm = ""
    //@Binding var userID: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image("left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            }
        }
    }
    
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
                    Text("Please create a username!")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack(alignment: .center) {

                    TextField("", text: $usernm)
                        .modifier(PlaceholderStyle(showPlaceHolder: usernm.isEmpty, placeholder: "Username"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                }
                .frame(alignment: .center)
                .foregroundColor(.white)
                
                Spacer()
                
                if (usernm.isEmpty){
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                }else{
                    NavigationLink(destination: ProfileCreationBday(name: $name, usernm: $usernm)){
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}

struct ProfileCreationUserNM_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationUserNM(name: .constant("John Doe"))
    }
}
