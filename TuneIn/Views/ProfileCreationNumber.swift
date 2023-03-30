//
//  ProfileCreationNumber.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//
// Check the phone number function using ChatGTP

import SwiftUI
import iPhoneNumberField

struct ProfileCreationNumber: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State private var phoneNumber: String = ""
    @State private var isEditing: Bool = false
    @State private var verificationComplete: Bool = false
    @State private var verificationCompleteOptional: Bool?
    @Binding var name: String
    @Binding var usernm: String
//    @Binding var userID: String
    
//    init(phoneNumber: Binding<String>, name: Binding<String>, usernm: Binding<String>) {
//            _phoneNumber = State(initialValue: phoneNumber.wrappedValue)
//            _name = name
//            _usernm = usernm
//        }
    
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
                    Text("We will send a code via SMS text message to your phone number. Message and data rates may apply.")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .opacity(0.8)
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
                        .background(Color.white)
                        .cornerRadius(10)
                        .accentColor(Color("Blue"))
                        .padding()
                }
                .frame(alignment: .center)
                
                
                Spacer()
                
                //                if !isValidPhoneNumber(phoneNumber){
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
                    NavigationLink(destination: ProfileCreationPhoneAuth(name: $name, usernm: $usernm, phoneNumber: $phoneNumber)) {
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
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

//TODO: Commenting this out for now until auth works, need to change this logic to allow +1 numbers
//func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
//    let numericRegEx = "^[0-9]{10}$"
//    let numericTest = NSPredicate(format: "SELF MATCHES %@", numericRegEx)
//    return numericTest.evaluate(with: phoneNumber)
//}


struct ProfileCreationNumber_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationNumber(name: .constant("John Doe"), usernm: .constant("username"))
    }
}
