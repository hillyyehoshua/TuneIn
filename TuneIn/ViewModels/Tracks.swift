//
//  Tracks.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import Foundation

struct Track: Codable, Identifiable {
    let id = UUID()
    var author: String
    var email: String
    var title: String
}
