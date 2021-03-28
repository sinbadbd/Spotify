/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Album : Codable {
	let album_type : String?
	let artists : [Artists]?
	let available_markets : [String]?
	let copyrights : [Copyrights]?
	let external_ids : External_ids?
	let external_urls : ExternalUrls?
	let genres : [String]?
	let href : String?
	let id : String?
	let images : [Images]?
	let name : String?
	let popularity : Int?
	let release_date : String?
	let release_date_precision : String?
	let tracks : Tracks?
	let type : String?
	let uri : String?

	enum CodingKeys: String, CodingKey {

		case album_type = "album_type"
		case artists = "artists"
		case available_markets = "available_markets"
		case copyrights = "copyrights"
		case external_ids = "external_ids"
		case external_urls = "external_urls"
		case genres = "genres"
		case href = "href"
		case id = "id"
		case images = "images"
		case name = "name"
		case popularity = "popularity"
		case release_date = "release_date"
		case release_date_precision = "release_date_precision"
		case tracks = "tracks"
		case type = "type"
		case uri = "uri"
	}

//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		album_type = try values.decodeIfPresent(String.self, forKey: .album_type)
//		artists = try values.decodeIfPresent([Artists].self, forKey: .artists)
//		available_markets = try values.decodeIfPresent([String].self, forKey: .available_markets)
//		copyrights = try values.decodeIfPresent([Copyrights].self, forKey: .copyrights)
//		external_ids = try values.decodeIfPresent(External_ids.self, forKey: .external_ids)
//		external_urls = try values.decodeIfPresent(External_urls.self, forKey: .external_urls)
//		genres = try values.decodeIfPresent([String].self, forKey: .genres)
//		href = try values.decodeIfPresent(String.self, forKey: .href)
//		id = try values.decodeIfPresent(String.self, forKey: .id)
//		images = try values.decodeIfPresent([Images].self, forKey: .images)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		popularity = try values.decodeIfPresent(Int.self, forKey: .popularity)
//		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
//		release_date_precision = try values.decodeIfPresent(String.self, forKey: .release_date_precision)
//		tracks = try values.decodeIfPresent(Tracks.self, forKey: .tracks)
//		type = try values.decodeIfPresent(String.self, forKey: .type)
//		uri = try values.decodeIfPresent(String.self, forKey: .uri)
//	}

}
