//
//  Song.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/21/23.
//

import SwiftUI

struct Song: Codable, Identifiable, Hashable{
    var id: String
    var artist: String
    var name: String
    var coverArt: String
    var album: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

