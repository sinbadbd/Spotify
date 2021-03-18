//
//  AudioTrack.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation

// MARK: - Track
struct AudioTrack: Codable {
    
//    let album: Ablum
//       let artists: [LinkedFrom]
//       let discNumber, durationMS: Int
//       let explicit: Bool
//       let externalIDS: ExternalIDS
//       let externalUrls: ExternalUrls
//       let href: String
//       let id: String
//       let isLocal, isPlayable: Bool
//       let name: String
//       let popularity: Int
//       let previewURL: String?
//       let trackNumber: Int
//       let type: LinkedFromType
//       let uri: String
//       let linkedFrom: LinkedFrom?
//
//       enum CodingKeys: String, CodingKey {
//           case album, artists
//           case discNumber = "disc_number"
//           case durationMS = "duration_ms"
//           case explicit
//           case externalIDS = "external_ids"
//           case externalUrls = "external_urls"
//           case href, id
//           case isLocal = "is_local"
//           case isPlayable = "is_playable"
//           case name, popularity
//           case previewURL = "preview_url"
//           case trackNumber = "track_number"
//           case type, uri
//           case linkedFrom = "linked_from"
//       }
    
    
    
        let album: Ablum
        let artists: [LinkedFrom]
        let disc_number, duration_ms: Int
        let explicit: Bool
        let external_ids: ExternalIDS
        let external_urls: ExternalUrls
    
        let href: String
        let id: String
        let is_local : Bool
//        let is_playable: Bool
    
        let name: String
        let popularity: Int
        let preview_url: String?
        let track_number: Int
        let type: LinkedFromType
        let uri: String
        let linked_from: LinkedFrom?

//    enum CodingKeys: String, CodingKey {
//        case album, artists
//        case discNumber = "disc_number"
//        case durationMS = "duration_ms"
//        case explicit
//        case externalIDS = "external_ids"
//        case externalUrls = "external_urls"
//        case href, id
//        case isLocal = "is_local"
//        case isPlayable = "is_playable"
//        case name, popularity
//        case previewURL = "preview_url"
//        case trackNumber = "track_number"
//        case type, uri
//        case linkedFrom = "linked_from"
//    }
}
