//
//  Song.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class Song: Equatable, Codable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        if lhs.artist != rhs.artist { return false }
        if lhs.title != rhs.title { return false }
        return true
    }
    
    let artist: String
    let title: String
    
    init(artist: String, title: String) {
        self.artist = artist
        self.title = title
    }
}
