//
//  TrackVM.swift
//  TuneIn
//
//  Created by Izzy Hood on 3/30/23.
//

import Foundation

func searchTracks(query: String, completion: @escaping ([Song]) -> Void) {
    let headers = [
        "X-RapidAPI-Key": "2f51a38241mshbf9576321496dcdp1897f0jsna7f7a56ff7e4",
        "X-RapidAPI-Host": "spotify23.p.rapidapi.com"
    ]
    
    // Encode the query string
    let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    
    let urlString = "https://spotify23.p.rapidapi.com/search/?q=\(encodedQuery)&type=tracks&offset=0&limit=10&numberOfTopResults=5"
    
    let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                       cachePolicy: .useProtocolCachePolicy,
                                       timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if let error = error {
            print(error)
            completion([])
        } else if let data = data {
            do {
                let apiResponse = try decodeAPIResponse(data)
                print(apiResponse)
                print(apiResponse.tracks.items)
                let songs = convertToSongs(tracks: apiResponse.tracks.items)
                completion(songs)
                // use the decoded API response here
            } catch {
                print(error)
                completion([])

            }
        }
    })
    dataTask.resume()
}


func decodeAPIResponse(_ data: Data) throws -> APIResponse {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let response = try decoder.decode(APIResponse.self, from: data)
    print(response)
    return response
}

func convertToSongs(tracks: [Track]) -> [Song] {
    var songs = [Song]()
    
    for track in tracks {
        let data = track.data
        let album = data.albumOfTrack
        let artist = data.artists.items.first?.profile.name ?? "Unknown Artist"
        let coverArt = album.coverArt.sources.first?.url ?? ""
        
        let song = Song(id: data.id,
                        artist: artist,
                        name: data.name,
                        coverArt: coverArt,
                        album: album.name)
        
        songs.append(song)
    }
    print(songs)
    return songs
}




