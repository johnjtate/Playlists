//
//  SongTableViewController.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {

    /// This is the info getting passed in the segue AKA LANDING PAD!
    var playlist: Playlist?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - IBOutlets
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        if artistTextField.text != "", songTextField.text != "" {
            guard let artistName = artistTextField.text,
                let songTitle = songTextField.text,
                let playlist = playlist else { return }
            
            SongController.shared.createSong(name: songTitle, artist: artistName, playlist: playlist)
            tableView.reloadData()
            
            artistTextField.text = ""
            songTextField.text = ""
            
            PlaylistController.shared.saveToPersistentStore()
        }
    }
    
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var songTextField: UITextField!
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let playlist = playlist else { return 0 }
        return playlist.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = playlist?.songs[indexPath.row]
        cell.textLabel?.text = song?.title
        cell.detailTextLabel?.text = song?.artist
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let playlist = playlist else { return }
            let song = playlist.songs[indexPath.row]
            
            SongController.shared.delete(song: song, from: playlist)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


}
