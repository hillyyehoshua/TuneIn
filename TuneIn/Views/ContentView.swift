
//  ContentView.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/23/23.
//

import SwiftUI

// Structure for the view that manages primary app screens and navigation.
struct ContentView: View {
    var body: some View {
        NavigationView {
            UploadSongView()
        }
//        VStack {
//            Spotify()
//        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
