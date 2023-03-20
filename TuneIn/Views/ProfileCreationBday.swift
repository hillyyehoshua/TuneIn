//
//  ProfileCreationBday.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//

import SwiftUI

struct ProfileCreationBday: View {
    
    @State private var birthdate = Date()
    @Binding var name: String
    @Binding var usernm: String
    
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
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Text("Hi \(name)! When's your birthday?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    Form {
                        DatePicker("Birthday", selection: $birthdate, in: ...Date(), displayedComponents: .date)
                            .modifier(PoppinsFont())
                    }
                    .listStyle(GroupedListStyle())
                    .background(Color("Dark Blue"))
                    .scrollContentBackground(.hidden)
                }
                

                
                Spacer()
                
                NavigationLink(
                    destination: ProfileCreationNumber(name: $name, usernm: $usernm)) {
                    HStack{
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 230, height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color("Blue")).shadow(radius: 3))
                    }
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
}


struct PoppinsFont: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Poppins", size: 16))
    }
}

struct ProfileCreationBday_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationBday(name: .constant("John Doe"), usernm: .constant("username"))
    }
}
