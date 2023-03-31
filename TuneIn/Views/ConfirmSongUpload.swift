//
//  ConfirmSongUpload.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import SwiftUI

struct ConfirmSongUpload: View {
    
    @Binding var isSearchBarHidden: Bool
    var selectedSong: Song
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Confirm Song Upload")
                .font(.headline)
            
            // Display song information
            AsyncImage(url: URL(string: selectedSong.coverArt)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "xmark.circle")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 200, height: 200)
            
            Text(selectedSong.name)
                .font(.title)
            
            Text("\(selectedSong.artist) - \(selectedSong.album)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                // Perform song upload and dismiss views
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Upload Song")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .padding(.top)
        }
        .padding()
        .navigationBarTitle("Confirm Upload", displayMode: .inline)
        .navigationBarHidden(isSearchBarHidden)
        .onAppear {
            isSearchBarHidden = true
        }
        .onDisappear {
            isSearchBarHidden = false
        }
    }
}


struct ConfirmSongUpload_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSongUpload(isSearchBarHidden: .constant(true), selectedSong: Song(id: "uniqueid", artist: "taylor swift", name: "this is me trying", coverArt: "https://i.scdn.co/image/ab67616d00001e02a9c080fdc40e78a4b81e0520", album: "folklore"))
    }
}
