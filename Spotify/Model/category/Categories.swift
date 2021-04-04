//
//  Category.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 3, 2021

import Foundation

struct Categories : Codable {

        let href : String?
        let items : [Category]?
        let limit : Int?
        let next : String?
        let offset : Int?
        let previous : Int?
        let total : Int?

        enum CodingKeys: String, CodingKey {
                case href = "href"
                case items = "items"
                case limit = "limit"
                case next = "next"
                case offset = "offset"
                case previous = "previous"
                case total = "total"
        }
    
//        init(from decoder: Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                href = try values.decodeIfPresent(String.self, forKey: .href)
//                items = try values.decodeIfPresent([Item].self, forKey: .items)
//                limit = try values.decodeIfPresent(Int.self, forKey: .limit)
//                next = try values.decodeIfPresent(String.self, forKey: .next)
//                offset = try values.decodeIfPresent(Int.self, forKey: .offset)
//                previous = try values.decodeIfPresent(AnyObject.self, forKey: .previous)
//                total = try values.decodeIfPresent(Int.self, forKey: .total)
//        }

}
