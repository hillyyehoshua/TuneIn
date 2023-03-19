//
//  AuthManager.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/7/23.
//

import Foundation
import SwiftUI

class AuthManager: ObservableObject {
    @Published var isSignedIn = false
    @Published var isAnonymous = false
    @Published var isLoading = true
    
    var spotifySecret: String
    var spotifyId: String
    
    struct Keys {
        // For storage.
        static let EXPIRATION = "EXPIRATION_DATE"
        static let ACCESS_TOKEN = "ACCESS_TOKEN"
        static let REFRESH_TOKEN = "REFRESH_TOKEN"
    }
    
    init() {
        
        spotifyId = spotifyClientId
        spotifySecret = spotifyClientSecretKey
        
        signIn()
        //signOut() // Uncomment this to clear cache at the startup.
    }
    
    public var signInURL: URL? {
        let scope = "user-library-modify%20user-library-read"
        let str = "\(SpotifyApi.AUTHENTICATE)?response_type=code&client_id=\(spotifyId)&scope=\(scope)&redirect_uri=\(SpotifyApi.REDIRECT)&show_dialog=TRUE"
        return URL(string: str)
    }
    
    
}
