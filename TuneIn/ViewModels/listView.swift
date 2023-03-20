//
//  listView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/18/23.
//

//import SwiftUI
//
//struct listView: View {
//    @EnvironmentObject var dataManager: DataManager
//
//    var body: some View {
//        NavigationView{
//            List (dataManager.users, id: \.id){ user in
//                Text (user.name)
//                    .foregroundColor(.black)
//
//            }
//            .navigationTitle("Users")
//            .navigationBarItems(trailing: Button(action : {
//                //add
//            }, label: {
//                Image(systemName: "plus")
//            }
//                                                ))
//
//        }
//
//    }
//}
//
//struct listView_Previews: PreviewProvider {
//    static var previews: some View {
//        listView()
//            .environmentObject(DataManager())
//    }
//}
