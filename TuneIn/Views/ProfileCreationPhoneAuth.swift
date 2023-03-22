//
//  ProfileCreationPhoneAuth.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/21/23.
//

import SwiftUI

struct ProfileCreationPhoneAuth: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State var verCode = ""
    @State var verificationComplete = false
    @Binding var name: String
    @Binding var usernm: String
    @Binding var phoneNumber: String
    
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
                Text("Please input the 6-digit verification code texted to your phone number")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.custom("Poppins", size: 18))
                
                HStack(alignment: .center) {
                    TextField("", text: $verCode)
                        .modifier(PlaceholderStyle(showPlaceHolder: verCode.isEmpty, placeholder: "XXXXXX"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                }
                .frame(alignment: .center)
                .foregroundColor(.white)
                
                if verCode.isEmpty{
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                    
                } else {
                    
                    NavigationLink(destination: ProfileCreationTimeZone(userID: "", name: $name, usernm: $usernm, phoneNumber : $phoneNumber),    isActive: $verificationComplete) {
                        VStack {
                            Button(
                                "Next",
                                action:{
                                    AuthManager.shared.verifyCode(smsCode: verCode) { success in
                                        if success {
                                            verificationComplete = true
                                            print("Code successfully verified")
                                        } else {
                                            print("Error, code could not be successfully verified")
                                        }
                                    }
                                }
                            )
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct ProfileCreationPhoneAuth_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationPhoneAuth(name: .constant("John Doe"), usernm: .constant("username"), phoneNumber: .constant("1234567890"))
    }
}
