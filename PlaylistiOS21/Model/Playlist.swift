//
//  Playlist.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class Playlist: Equatable, Codable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        if lhs.name != rhs.name { return false }
        if lhs.songs != rhs.songs { return false }
        return true
    }
    
    
    let name: String
    var songs: [Song] = []

    init(name: String, songs: [Song] = []) {
        self.name = name
        self.songs = songs
    }
}


