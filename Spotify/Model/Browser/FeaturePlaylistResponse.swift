//
//  FeaturePlaylistResponse.swift
//  Spotify
//
//  Created by Imran on 17/3/21.
//

import Foundation

// MARK: - FeaturePlaylistResponse
struct FeaturePlaylistResponse: Codable {
    let message: String
    let playlists: PlaylistResponse
}

// MARK: - Playlists
struct PlaylistResponse: Codable {
    let href: String
    let items: [PlayList]
//    let limit: Int
//    let next: String
//    let offset: Int
//    let previous: JSONNull?
//    let total: Int
}



// MARK: - Owner
struct User: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, type, uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

//// MARK: - Tracks
//struct Tracks: Codable {
//    let href: String
//    let total: Int
//}
