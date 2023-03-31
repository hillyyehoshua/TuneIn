//
//  Response.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import Foundation

struct APIResponse: Codable {
    let query: String
    let tracks: Tracks
}

struct Tracks: Codable {
    let totalCount: Int
    let items: [Track]
    let pagingInfo: PagingInfo
}

struct Track: Codable {
    let data: TrackData
}

struct TrackData: Codable {
    let uri: String
    let id: String
    let name: String
    let albumOfTrack: AlbumOfTrack
    let artists: Artists
    let contentRating: ContentRating
    let duration: Duration
    let playability: Playability
}

struct AlbumOfTrack: Codable {
    let uri: String
    let name: String
    let coverArt: CoverArt
    let id: String
    let sharingInfo: SharingInfo
}

struct CoverArt: Codable {
    let sources: [Source]
}

struct Source: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct SharingInfo: Codable {
    let shareUrl: String
}

struct Artists: Codable {
    let items: [Artist]
}

struct Artist: Codable {
    let uri: String
    let profile: Profile
}

struct Profile: Codable {
    let name: String
}

struct ContentRating: Codable {
    let label: String
}

struct Duration: Codable {
    let totalMilliseconds: Int
}

struct Playability: Codable {
    let playable: Bool
}

struct PagingInfo: Codable {
    let nextOffset: Int
    let limit: Int
}
