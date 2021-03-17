//
//  Artist.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation


// MARK: - Artist
struct Artist : Codable{
   let externalUrls: ExternalUrls
    let href: String
    let id, name, type, uri: String
    
    enum CodingKeys: String, CodingKey {
            case externalUrls = "external_urls"
            case href, id, name, type, uri
        }
}
