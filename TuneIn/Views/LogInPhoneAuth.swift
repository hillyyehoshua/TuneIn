//
//  LogInPhoneAuth.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/22/23.
//

import SwiftUI

struct LogInPhoneAuth: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State var verCode = ""
    @State var verificationComplete = false
    
    //MARK: CUSTOM BACK BUTTON CODE
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
    //END: CUSTOM BACK BUTTON CODE
    
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
                
                Text("Please input the 6-digit verification code texted to your phone number")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.custom("Poppins", size: 16))
                    .padding()
                
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
                    
                    NavigationLink(destination: FeedEmpty()) {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 230, height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                    }
                    .simultaneousGesture(TapGesture().onEnded({
                        let _ = print("[DEBUG] Pressed button that should call startAuth")
                        AuthManager.shared.verifyCode(smsCode: verCode) { success in
                            if success {
                                print("[DEBUG] Success with phone authentication")
                                verificationComplete = true
                                AuthManager.shared.linkPhoneNumberAuthWithOriginalUid { success in
                                    if (success != nil) {
                                        print("[DEBUG] Linked old UID with new UID")
                                        dataManager.fetchCurrentUser { user, error  in
                                            if error != nil {
                                                print("[DEBUG] Error fetching current user after loging in and linking uids")
                                            } else if let user = user {
                                                print("[DEBUG] Fetched current user with id after loging in and linking uids: \(user.id)")
                                            }
                                        }
                                    } else {
                                        print("[DEBUG] Error with linking accounts")
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            } else {
                                print("[DEBUG] Error with phone authentication")
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }))
                    
                    
                    //TODO: Change navigation destination to feed with current user info
//                    NavigationLink(destination: EmptyView(),    isActive: $verificationComplete) {
//                        VStack {
//                            Button(
//                                "Next",
//                                action:{
//                                    AuthManager.shared.verifyCode(smsCode: verCode) { success in
//                                        if success {
//                                            verificationComplete = true
//                                            print("Code successfully verified")
//                                        } else {
//                                            print("Error, code could not be successfully verified")
//                                        }
//                                    }
//                                }
//                            )
//                            .foregroundColor(.white)
//                            .font(.custom("Poppins-Regular", size: 16))
//                            .fixedSize(horizontal: false, vertical: true)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .frame(width: 230, height: 50)
//                            .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
//                        }
//                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}



struct LogInPhoneAuth_Previews: PreviewProvider {
    static var previews: some View {
        LogInPhoneAuth()
    }
}
