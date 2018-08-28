//
//  SongController.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/23/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class SongController {
    
    // Singleton or "Shared Instance"
    static let shared = SongController()
    
    // CRUD
    
    // Create
    func createSong(name: String, artist: String, playlist: Playlist) {
        let song = Song(artist: artist, title: name)
        playlist.songs.append(song)
        
        PlaylistController.shared.saveToPersistentStore()
    }
    
    // Delete
    
    func delete(song: Song, from playlist: Playlist) {
        guard let index = playlist.songs.index(of: song) else { return }
        playlist.songs.remove(at: index)
        
        PlaylistController.shared.saveToPersistentStore()
    }
    
    
}
