//
//  ProfileCreationNumber.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//
// Check the phone number function using ChatGTP

import SwiftUI

struct ProfileCreationNumber: View {
    
    @State private var phoneNumber: String = ""
    @Binding var name: String
    @Binding var usernm: String
    
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
                  
                if !isValidPhoneNumber(phoneNumber){
                    Text("Next")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: 230, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                }else{
                    NavigationLink(destination: ProfileCreationTimeZone(name: $name, usernm: $usernm, phoneNumber : $phoneNumber, userID: "")){
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    let numericRegEx = "^[0-9]{10}$"
    let numericTest = NSPredicate(format: "SELF MATCHES %@", numericRegEx)
    return numericTest.evaluate(with: phoneNumber)
}


struct ProfileCreationNumber_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationNumber(name: .constant("John Doe"), usernm: .constant("username"))
    }
}
