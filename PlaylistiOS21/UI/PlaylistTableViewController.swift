//
//  PlaylistTableViewController.swift
//  PlaylistiOS21
//
//  Created by John Tate on 8/22/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUPUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        
        if let playlistName  = nameTextField.text, playlistName != "" {
        PlaylistController.shared.createPlaylist(name: playlistName)
        // TableView go do your job again.
        tableView.reloadData()
        // This clears the text field.
        nameTextField.text = ""
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        // This is an individual playlist for each row.
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(playlist.songs.count)"        
        
        return cell
    }
    
    // MARK: - Visual effect
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let clearColor = UIColor.clear
        cell.backgroundColor = UIColor(white: 1, alpha: 0.2)
        cell.textLabel?.backgroundColor = clearColor
        cell.detailTextLabel?.backgroundColor = clearColor
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            // Delete Playlist from the Source of Truth
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlistToDelete: playlist)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 1) First check your segue ID
        if segue.identifier == "toSongVC" {
        
            // 2) Get your destination VC
            let destinationVC = segue.destination as? SongTableViewController
        
            // 3) Get the selected row that the user tapped
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            
            // 4) Pass your infor to your mailbox or landing pad
            destinationVC?.playlist = playlist
            
        }
        
    }
    
}

extension PlaylistTableViewController {
    
    // MARK: - UI
    
    func setUPUI() {
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "sunSetSki"))
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        
        // Make a blur effect
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        imageView.clipsToBounds = true
    }
}
