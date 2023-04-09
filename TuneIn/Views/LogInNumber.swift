//
//  LogInNumber.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/22/23.
//

import SwiftUI
import iPhoneNumberField


struct LogInNumber: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State var phoneNumber = ""
    @State var isEditing: Bool = false
    @State var verificationComplete = false
//    @State private var phoneExists: Bool = true
    @State private var phoneExists: Bool = true // Change type to optional Bool


    
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
                    iPhoneNumberField("+1 (000) 000-0000", text: $phoneNumber, isEditing: $isEditing)
                        .flagHidden(false)
                        .multilineTextAlignment(.center)
                        .flagSelectable(true)
                        .prefixHidden(false)
                        .font(UIFont(name:"Poppins-SemiBold", size: 30))
                        .clearButtonMode(.whileEditing)
                        .maximumDigits(10)
                        .onClear { _ in isEditing.toggle() }
                        .padding()
                        .keyboardType(.numberPad)
                        .background(Color.white)
                        .cornerRadius(10)
                        .accentColor(Color("Blue"))
                        .padding()
                }
                .frame(alignment: .center)
                
                
                
                
                
//                Spacer()
//                let phoneNumber = self.$phoneNumber.wrappedValue
//
//                let phoneExists = dataManager.checkPhoneDoesntExists(phoneNum: phoneNumber) { exists in
//                    if exists {
//                        print("Phone number already exists in database.")
//                    } else {
//                        print("Phone number does not exist in database.")
//                        // Add the user to the database here
//                    }
//                }
//                Button(action: {
//                    print ("getting into the Button in LogInNumber to set phone number ")
//                                    let phoneNumber = self.$phoneNumber.wrappedValue
//                                    
//                                    dataManager.checkPhoneDoesntExists(phoneNum: phoneNumber) { exists in
//                                        if exists {
//                                            print("Phone number already exists in database.")
//                                            phoneExists = true
//                                        } else {
//                                            print("Phone number does not exist in database.")
//                                            phoneExists = false
//                                            // Add the user to the database here
//                                        }
//                                    }
//                                    
//                                }) {
//                                    Text("Check if phone exists")
//                                        .foregroundColor(.white)
//                                }
//                                .padding()
//                
                
                
                
                if phoneNumber.isEmpty {
                    let _ = print ("getting into the isEmpty in LogInNumber ")
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                    
                }
                else{
                    let _ = print ("getting into the else in LogInNumber")
                    NavigationLink(destination: LogInPhoneAuth()) {
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
                        let _ = print("Pressed button that should call startAuth")
                        AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
                            if success {
                                print("Success with phone authentication")
                                verificationComplete = true
                            } else {
                                print("Error with phone authentication")
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }))
                    
                    
                    //TODO: remove stuff below
//                    NavigationLink(destination: LogInPhoneAuth(), isActive: $verificationComplete) {
//                        VStack {
//                            Button(
//                                "Next",
//                                action:{
//                                    AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
//                                        if success {
//                                            print("Success with phone authentication")
//                                            verificationComplete = true
//                                        } else {
//                                            print("Error with phone authentication")
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
//
//                        }
//                    }
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
