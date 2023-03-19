//
//  ProfileCreationBday.swift
//  TuneIn
//
//  Created by Izzy Hood on 1/30/23.
//

import SwiftUI

struct ProfileCreationBday: View {
    
    @State private var birthdate = Date()
    
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
                    Text("Hi Isabella! When's your birthday?")
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
                    .scrollContentBackground(.hidden)
                    .background(Color("Dark Blue"))
                }

                
                Spacer()
                
//                if birthdate != Date() {
//                                    Text("Next")
//                                        .foregroundColor(.white)
//                                        .font(.custom("Poppins-Regular", size: 16))
//                                        .fixedSize(horizontal: false, vertical: true)
//                                        .multilineTextAlignment(.center)
//                                        .padding()
//                                        .frame(width: 230, height: 50)
//                                        .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
//                                }else{
                                    NavigationLink(destination: ProfileCreationNumber()){
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
                                    }//end nav link
                                //}




                
            }
            
        }
    }
}


struct PoppinsFont: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("Poppins", size: 16))
    }
}

struct ProfileCreationBday_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationBday()
    }
}
