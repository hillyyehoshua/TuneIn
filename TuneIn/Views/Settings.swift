//
//  Settings.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

struct Settings: View {
    
    @Binding var name: String
    @Binding var usernm: String
    @Binding var userID: String
    
    // MARK: Custom back button code
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
    // END: Custom back button code
    
    var body: some View {
        ZStack{
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Header
            VStack {
                ZStack{
                    HStack {
                        Text("Settings")
                            .frame(alignment: .center)
                            .foregroundColor(.white)
                            .font(.custom("Poppins-SemiBold", size: 30))
                    }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 74)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("Blue"))
                                .frame(width: 52, height: 52)
                            Text(String(name.first!))
                                .font(.custom("Poppins-Regular", size: 25))
                        }
                        .padding(.leading, 35)
                        VStack (alignment: .leading){
                            Text(name)
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .padding(.leading, 5)
                            Text(usernm)
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 14))
                                .padding(.leading, 5)
                        }
                        Spacer()
                        HStack {
                            Image("right")
                                .frame(alignment: .trailing)
                        }
                        .padding(.trailing, 35)
                    }
                }
                
                
                
                Spacer()
                    .frame(height: 35)
                
                    Group{
                        // "Your Library" card
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                                .opacity(0.1)
                                .frame(width: 348, height: 43)
                            HStack{
                                Image("Library")
                                    .frame(width: 25, height: 25, alignment: .leading)
                                    .padding(.leading, 35)
                                
                                
                                NavigationLink(destination: MyProfile()){
                                    Text("Your Library")
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Regular", size: 16))
                                        .padding(.leading, 5)
                                }
                                
                                
                                
                                
                                Spacer()
                                
                                HStack{
                                    Image("right")
                                        .frame(alignment: .trailing)
                                }
                                .padding(.trailing, 35)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // "Notifications" Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                                .opacity(0.1)
                                .frame(width: 348, height: 43)
                            HStack{
                                Image("Alarm")
                                    .frame(width: 25, height: 25, alignment: .leading)
                                    .padding(.leading, 35)
                                
                                
                                NavigationLink(destination: Notifications()){
                                    Text("Notifications")
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Regular", size: 16))
                                        .padding(.leading, 5)
                                    
                                }
                                
                                Spacer()
                                
                                HStack{
                                    Image("right")
                                        .frame(alignment: .trailing)
                                }
                                .padding(.trailing, 35)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // "Time Zone" Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                                .opacity(0.1)
                                .frame(width: 348, height: 43)
                            HStack{
                                Image("Globe")
                                    .frame(width: 25, height: 25, alignment: .leading)
                                    .padding(.leading, 35)
                                
                                Text("Time Zone")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                HStack{
                                    Image("right")
                                        .frame(alignment: .trailing)
                                }
                                .padding(.trailing, 35)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        
                        // "Contact Us" Card
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.white)
                                .opacity(0.1)
                                .frame(width: 348, height: 43)
                            HStack{
                                Image("Envelope")
                                    .frame(width: 25, height: 25, alignment: .leading)
                                    .padding(.leading, 35)
                                
                                Text("Contact Us")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .padding(.leading, 5)
                                
                                Spacer()
                                
                                HStack{
                                    Image("right")
                                        .frame(alignment: .trailing)
                                }
                                .padding(.trailing, 35)
                            }
                        }
                    }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                        .opacity(0.1)
                        .frame(width: 348, height: 52)
                    Text("Log Out")
                        .foregroundColor(.red)
                        .font(.custom("Poppins-SemiBold", size: 18))
                }
            }
        }

        // Enables Custom back button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(name: .constant("John Doe"), usernm: .constant("username"), userID: .constant("UniqueID"))
    }
}
