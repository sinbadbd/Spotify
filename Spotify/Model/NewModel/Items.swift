/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Items : Codable {
	let artists : [Artists]?
	let available_markets : [String]?
	let disc_number : Int?
	let duration_ms : Int?
	let explicit : Bool?
	let external_urls : ExternalUrls?
	let href : String?
	let id : String?
	let name : String?
	let preview_url : String?
	let track_number : Int?
	let type : String?
	let uri : String?

	enum CodingKeys: String, CodingKey {

		case artists = "artists"
		case available_markets = "available_markets"
		case disc_number = "disc_number"
		case duration_ms = "duration_ms"
		case explicit = "explicit"
		case external_urls = "external_urls"
		case href = "href"
		case id = "id"
		case name = "name"
		case preview_url = "preview_url"
		case track_number = "track_number"
		case type = "type"
		case uri = "uri"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		artists = try values.decodeIfPresent([Artists].self, forKey: .artists)
//		available_markets = try values.decodeIfPresent([String].self, forKey: .available_markets)
//		disc_number = try values.decodeIfPresent(Int.self, forKey: .disc_number)
//		duration_ms = try values.decodeIfPresent(Int.self, forKey: .duration_ms)
//		explicit = try values.decodeIfPresent(Bool.self, forKey: .explicit)
//		external_urls = try values.decodeIfPresent(External_urls.self, forKey: .external_urls)
//		href = try values.decodeIfPresent(String.self, forKey: .href)
//		id = try values.decodeIfPresent(String.self, forKey: .id)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		preview_url = try values.decodeIfPresent(String.self, forKey: .preview_url)
//		track_number = try values.decodeIfPresent(Int.self, forKey: .track_number)
//		type = try values.decodeIfPresent(String.self, forKey: .type)
//		uri = try values.decodeIfPresent(String.self, forKey: .uri)
//	}

}
