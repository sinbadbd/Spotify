//
//  SettingsModel.swift
//  Spotify
//
//  Created by Imran on 10/3/21.
//

import Foundation

struct Section{
    let title : String
    let option: [Option]
}

struct Option {
    let title : String
    let handler: () -> Void
}
