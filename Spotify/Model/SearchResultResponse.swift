//
//  SearchResultResponse.swift
//  Spotify
//
//  Created by Imran on 12/4/21.
//

import Foundation

struct SearchResultResponse: Codable {
    
    let albums : SearchAlbumResponse
    let artists : SearchArtistsResponse
    let tracks : SearchAudioTrackResponse
    let playlists : SearchPlayListponse
}

struct SearchAlbumResponse: Codable {
    let items:[Album]
}
struct SearchArtistsResponse: Codable {
    let items:[Artists]
}

struct SearchAudioTrackResponse: Codable {
    let items:[AudioTrack]
}

struct SearchPlayListponse: Codable {
    let items:[PlayList]
}
