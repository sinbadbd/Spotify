//
//  Icon.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 3, 2021

import Foundation

struct Icon : Codable {

        let height : Int?
        let url : String?
        let width : Int?

        enum CodingKeys: String, CodingKey {
                case height = "height"
                case url = "url"
                case width = "width"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                height = try values.decodeIfPresent(Int.self, forKey: .height)
                url = try values.decodeIfPresent(String.self, forKey: .url)
                width = try values.decodeIfPresent(Int.self, forKey: .width)
        }

}
