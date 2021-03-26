//
//  PlayListDetailsResponse.swift
//  Spotify
//
//  Created by Imran on 25/3/21.
//

import Foundation

/*
 
 
 struct PlayListDetailsResponse : Codable {
     let description: String
     let id: String
     let name: String
     let images : [APIImage]
     let tracks: ParentTracksList
 }

 struct ParentTracksList: Codable {
     let href: String
     let items: [itemsList]
 }

 struct itemsList:Codable {
     let is_local: Bool
     let track : listData
 }

 struct listData: Codable {
     let album: Album
     let artists: Artist
 }
 */


// MARK: - PlayListDetailsResponse
struct PlayListDetailsResponse: Codable {
    let collaborative: Bool
    let description: String
    let externalUrls: ExternalUrls
    //    let followers: Followers
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
    //    let publilList: String
    let snapshotID: String
    let tracks: TracksList
    let type, uri: String
    
    enum CodingKeys: String, CodingKey {
        case collaborative
        case description = "description"
        case externalUrls = "external_urls"
        case  href, id, images, name, owner
        //        case publilList = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
//struct ExternalUrls: Codable {
//    let spotify: String
//}

// MARK: - Followers
struct Followers: Codable {
    let href: String
    let total: Int
}

// MARK: - PlayListDetailsResponseImage
struct PlayListDetailsResponseImage: Codable {
    let url: String
}

// MARK: - Owner
struct OwnUser: Codable {
    let externalUrls: ExternalUrls
    let href: String
    let id, type, uri: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, type, uri, name
    }
}

// MARK: - Tracks
struct TracksList: Codable {
    let href: String
    let items: [ItemList]
    //    let limit: Int
    //    let next: String
    //    let offset: Int
    //    let previous: JSONNull?
    //    let total: Int
}

// MARK: - Item
struct ItemList: Codable {
//    let addedAt: Date
//    let addedBy: User
//    let isLocal: Bool
    let track: AudioTrack

//    enum CodingKeys: String, CodingKey {
//        case addedAt = "added_at"
//        case addedBy = "added_by"
//        case isLocal = "is_local"
//        case track
//    }
}

// MARK: - Track
//struct Track: Codable {
//    let album: Album
//    let artists: [Owner]
//    let availableMarkets: [String]
//    let discNumber, durationMS: Int
//    let explicit: Bool
//    let externalIDS: ExternalIDS
//    let externalUrls: ExternalUrls
//    let href: String
//    let id, name: String
//    let popularity: Int
//    let previewURL: String
//    let trackNumber: Int
//    let type, uri: String
//
//    enum CodingKeys: String, CodingKey {
//        case album, artists
//        case availableMarkets = "available_markets"
//        case discNumber = "disc_number"
//        case durationMS = "duration_ms"
//        case explicit
//        case externalIDS = "external_ids"
//        case externalUrls = "external_urls"
//        case href, id, name, popularity
//        case previewURL = "preview_url"
//        case trackNumber = "track_number"
//        case type, uri
//    }
//}

// MARK: - Album
//struct Album: Codable {
//    let albumType: String
//    let availableMarkets: [String]
//    let externalUrls: ExternalUrls
//    let href: String
//    let id: String
//    let images: [AlbumImage]
//    let name, type, uri: String
//
//    enum CodingKeys: String, CodingKey {
//        case albumType = "album_type"
//        case availableMarkets = "available_markets"
//        case externalUrls = "external_urls"
//        case href, id, images, name, type, uri
//    }
//}

// MARK: - AlbumImage
//struct AlbumImage: Codable {
//    let height: Int
//    let url: String
//    let width: Int
//}

// MARK: - ExternalIDS
//struct ExternalIDS: Codable {
//    let isrc: String
//}
