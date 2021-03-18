//
//  RecommandationResonse.swift
//  Spotify
//
//  Created by Imran on 18/3/21.
//

import Foundation

struct RecommandationResonse: Codable {
    let tracks: [AudioTrack]
    let seeds: [Seed]
}


// MARK: - Seed
struct Seed: Codable {
    let initialPoolSize, afterFilteringSize, afterRelinkingSize: Int
    let id, type: String
    let href: String?
}


// MARK: - LinkedFrom
struct LinkedFrom: Codable {
    let external_urls: ExternalUrls
    let href: String
    let id: String
    let name: String?
    let type: LinkedFromType
    let uri: String
    
//    enum CodingKeys: String, CodingKey {
//        case externalUrls = "external_urls"
//        case href, id, name, type, uri
//    }
}

enum LinkedFromType: String, Codable {
    case artist = "artist"
    case track = "track"
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String
}

//enum ReleaseDatePrecision: String, Codable {
//    case day = "day"
//}
//
//enum AlbumTypeEnum: String, Codable {
//    case album = "album"
//}
