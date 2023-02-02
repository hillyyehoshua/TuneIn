//
//  FriendCard.swift
//  TuneIn
//
//  Created by Izzy Hood on 2/1/23.
//

import SwiftUI

struct FriendCard: View {
    var body: some View {
        // start friend card
        HStack {
            ZStack {
                Circle()
                    .fill(Color("Blue"))
                    .frame(width: 50, height: 50)
                Text("L")
                    .font(.custom("Poppins-Regular", size: 24))
            }
            .padding(.leading, 20)
            
            VStack (alignment: .leading) {
                Text("Lauren Maresca")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-SemiBold", size: 16))
                
                Text("lau4mar")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .opacity(0.1)
                    .frame(width: 60, height: 30)
                
                Text("Add")
                    .foregroundColor(.white)
                    .font(.custom("Poppins-SemiBold", size: 14))
            }
            .padding(.trailing, 20)
        }
        // end friend card
    }
}

struct FriendCard_Previews: PreviewProvider {
    static var previews: some View {
        FriendCard()
    }
}
