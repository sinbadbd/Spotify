//
//  GetAllNewReleases.swift
//  Spotify
//
//  Created by Imran on 17/3/21.

import Foundation

// MARK: - GetAllNewReleases
struct NewReleasesResponse: Codable {
    let albums: AlbumsResponse
}

// MARK: - Albums
struct AlbumsResponse: Codable{
    let href: String
    let items: [Item]
    //  let limit: Int
    //  let next: String
    //  let offset: Int
    //  let previous: Int
    //  let total: Int
}

// MARK: - Item
struct Item: Codable{
     let albumType: String?
       let artists: [Artist]?
       let availableMarkets: [String]?
       let externalUrls: ExternalUrls?
       let href: String?
       let id: String?
       let images: [APIImage]?
       let name, type, uri: String?

       enum CodingKeys: String, CodingKey {
           case albumType = "album_type"
           case artists
           case availableMarkets = "available_markets"
           case externalUrls = "external_urls"
           case href, id, images, name, type, uri
       }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable{
    let spotify: String
}
