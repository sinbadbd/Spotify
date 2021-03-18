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
    let items: [Ablum]
    //  let limit: Int
    //  let next: String
    //  let offset: Int
    //  let previous: Int
    //  let total: Int
}



// MARK: - ExternalUrls
struct ExternalUrls: Codable{
    let spotify: String
}
