//
//  PlaylistController.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

class PlaylistController {
    
    // Prevents two instances from reaching your variables and methods.  It creates ONLY ONE instance to give you access to its instance methods and variables.
    static let shared = PlaylistController()
    
    // SOURCE OF TRUTH
    var playlists: [Playlist] = []
    
    init() {
        // match the local array to the loaded array
        playlists = loadFromPersistentStore()
    }
    
    // Create
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        
        saveToPersistentStore()
    }
    
    // Read
    
    
    // Delete
    func deletePlaylist(playlistToDelete: Playlist) {
        guard let index = playlists.index(of: playlistToDelete) else { return }
        playlists.remove(at: index)
        
        saveToPersistentStore()
    }
    
    // - MARK: Persistence
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "playlists.json"
        let fullURL = documentsDirectory.appendingPathComponent(fileName)
        print(fullURL)
        return fullURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(playlists)
            print(data)
            try data.write(to: fileURL())
        } catch {
            print("There was an error Saving to Persistent Store \(error) \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [Playlist] {
        do{
            let data = try Data(contentsOf: fileURL())
            let decoder = JSONDecoder()
            let playlists = try decoder.decode([Playlist].self, from: data)
            return playlists
        } catch {
            print("There was an error Loading from Persistent Store \(error) \(error.localizedDescription)")
        }
        return []
    }
    
    
    
}
