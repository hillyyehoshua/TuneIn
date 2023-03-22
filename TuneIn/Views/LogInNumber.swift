//
//  LogInNumber.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/22/23.
//

import SwiftUI


struct LogInNumber: View {
    
    @State var phoneNumber = ""
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
        
        ZStack{
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
                    Text("Welcome back! Enter your phone number to sign in to TuneIn.")
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .padding()
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack(alignment: .center) {
                    TextField("", text: $phoneNumber)
                        .modifier(PlaceholderStyle(showPlaceHolder: phoneNumber.isEmpty, placeholder: "+1 ___-___-____"))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 36))
                }
                .frame(alignment: .center)
                .foregroundColor(.white)
                
                
                Spacer()
                
                if phoneNumber.isEmpty {
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                    
                } else{
                    NavigationLink(destination: LogInPhoneAuth(), isActive: $verificationComplete) {
                        VStack {
                            Button(
                                "Next",
                                action:{
                                    AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
                                        if success {
                                            print("Success with phone authentication")
                                            verificationComplete = true
                                        } else {
                                            print("Error with phone authentication")
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

struct LogInNumber_Previews: PreviewProvider {
    static var previews: some View {
        LogInNumber()
    }
}
