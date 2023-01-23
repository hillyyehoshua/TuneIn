//
//  ContentView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

// Structure for the view that manages primary app screens and navigation.
struct ContentView: View {
    var body: some View {
        ZStack{
            Color ("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            VStack (alignment: .center){
                HStack{
                    Text("TuneIn")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 58))
                    Image(systemName:"play.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .padding(.top, 25)
                }
                Spacer()
                    .frame(height: 30)
                HStack{
                    Spacer()
                    Text("Get Started by signing into your Spotify Account")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 15)
                        .font(.custom("Poppins-Regular", size: 20))
                    Spacer()
                }
                
                    
                
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 import SwiftUI
 import UIKit

 // Structure for the view that manages primary app screens and navigation.
 struct ContentView: View {
     @EnvironmentObject var session: OnboardingVM
     @State private var selection: Int = 0
     @State private var addPostPresented = false
     
     init() {
         UITabBar.appearance().backgroundColor = .white
         UITabBar.appearance().unselectedItemTintColor = .black
         UITabBar.appearance().itemPositioning = .centered
     }
     
     var body: some View {
         NavigationStack {
             TabView(selection: $selection) {
                 // Icon to navigate to home marketplace screen.
                 HomeView(tabSelection: $selection)
                     .tabItem {
                         if (selection == 0) {
                             Image(systemName: "house.fill")
                         }
                         else {
                             Image(systemName: "house")
                                 .environment(\.symbolVariants, .none)
                         }
                     }
                     .tag(0)
                 
                 // Icon to navigate to main messaging screen.
                 MainMessagesView()
                     .tabItem {
                         if (selection == 1) {
                             Image(systemName: "message.fill")
                         }
                         else {
                             Image(systemName: "message")
                                 .environment(\.symbolVariants, .none)
                         }
                     }
                     .tag(1)
                 
                 // Icon to navigate to profile view screen.
                 ProfileView(tabSelection: $selection)
                     .tabItem {
                         if (selection == 2) {
                             Image(systemName: "person.fill")
                         }
                         else {
                             Image(systemName: "person")
                                 .environment(\.symbolVariants, .none)
                         }
                     }
                     .tag(2)
             }
             .accentColor(.black)
             .navigationBarHidden(true)
         }
         .environmentObject(session)
     }
 }

 */
