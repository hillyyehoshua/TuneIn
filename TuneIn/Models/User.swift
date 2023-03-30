//
//  User.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 3/20/23.
//

import SwiftUI

struct User: Codable{
    var _id: String = ""
    var name : String = ""
    var username: String = ""
    var phone: String = ""
    var timezone: String = ""
    var friends: [String] = []
}

extension User: Identifiable {
    var id: String { _id }
}
