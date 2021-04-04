//
//  Item.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 3, 2021

import Foundation

struct Category : Codable {

        let href : String?
        let icons : [APIImage]?
        let id : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case href = "href"
                case icons = "icons"
                case id = "id"
                case name = "name"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                href = try values.decodeIfPresent(String.self, forKey: .href)
//                icons = try values.decodeIfPresent([Icon].self, forKey: .icons)
//                id = try values.decodeIfPresent(String.self, forKey: .id)
//                name = try values.decodeIfPresent(String.self, forKey: .name)
//        }

}
