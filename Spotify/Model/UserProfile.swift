//
//  userProfile.swift
//  Spotify
//
//  Created by Imran on 7/3/21.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    let country: String
    let display_name: String
//    let explicit_content: [String: Int]
//    let external_urls: [String: String]
//    let followers: [String: String]
    let images: [ProfileImage]
    let type: String
    let product: String
}

struct ProfileImage: Codable{

//    let height : Int
//    let width: Int
    let url : String
  
}

/*
 
 {
     country = BD;
     "display_name" = sinbad;
     "explicit_content" =     {
         "filter_enabled" = 0;
         "filter_locked" = 0;
     };
     "external_urls" =     {
         spotify = "https://open.spotify.com/user/94ug9qfglojo3x6tpprzi3cgv";
     };
     followers =     {
         href = "<null>";
         total = 0;
     };
     href = "https://api.spotify.com/v1/users/94ug9qfglojo3x6tpprzi3cgv";
     id = 94ug9qfglojo3x6tpprzi3cgv;
     images =     (
                 {
             height = "<null>";
             url = "https://i.scdn.co/image/ab6775700000ee85e4b5ffcd5ce01f9bf92d2ce1";
             width = "<null>";
         }
     );
     product = open;
     type = user;
     uri = "spotify:user:94ug9qfglojo3x6tpprzi3cgv";
 }
 */
