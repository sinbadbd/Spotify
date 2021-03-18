//
//  PlayList.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation
// MARK: - Item
struct PlayList: Codable {
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
//    let images: [APIImage]
    let name: String
    let owner: User
    let itemPublic: String?
    let snapshotID: String
    let tracks: Tracks
    let type, uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href, id, name, owner
//        case images
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}
