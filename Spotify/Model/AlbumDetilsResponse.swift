//
//  AlbumDetilsResponse.swift
//  Spotify
//
//  Created by Imran on 25/3/21.
//

import Foundation

struct AlbumDetilsResponse: Codable {
    let album_type: String
    let artists: [Artists]
    let available_markets: [String]
//    let external_ids: ExternalIDS
    let external_urls: ExternalUrls
    let genres: [String]
    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let popularity: Int
    let release_date, release_date_precision: String
    let tracks: Tracks
    let type, uri: String
}
/*
 enum CodingKeys: String, CodingKey {
 case albumType = "album_type"
 case artists
 case availableMarkets = "available_markets"
 case copyrights
 case externalIDS = "external_ids"
 case externalUrls = "external_urls"
 case genres, href, id, images, name, popularity
 case releaseDate = "release_date"
 case releaseDatePrecision = "release_date_precision"
 case tracks, type, uri
 }
 
 */
