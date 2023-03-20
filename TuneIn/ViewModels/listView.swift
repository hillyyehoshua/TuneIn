//
//  listView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/18/23.
//

import SwiftUI

struct listView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showPopup = false
    
    var body: some View {
        NavigationView{
            List (dataManager.users, id: \.id){ user in
                Text (user.name)
                    .foregroundColor(.black)
            }
            .navigationTitle("Users")
            .navigationBarItems(trailing: Button(action : {
                showPopup.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showPopup){
                NewUserView()
            
                
            }
            
        }
        
    }
}

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        listView()
            .environmentObject(DataManager())
    }
}
