//
//  SearchResult.swift
//  Spotify
//
//  Created by Imran on 12/4/21.
//

import Foundation

enum SearchResult {
    case albums(mode: Album)
    case artists(mode: Artists)
    case tracks(mode: AudioTrack)
    case playlists(mode: PlayList)
}
