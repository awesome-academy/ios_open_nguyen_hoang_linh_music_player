//
//  TableViewController.swift
//  MusicApp
//
//  Created by Hoang Linh Nguyen on 23/8/2023.
//

import UIKit

final class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private weak var songTableView: UITableView!
    private var songList = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.dataSource = self
        songTableView.delegate = self
        initSongList()
    }
    
    func initSongList(){
        let songs = [Song(songImage: "album1", songName: "Album 1", songArtist: "Ngọt", songURL: "album1"),
                     Song(songImage: "album2", songName: "Album 2", songArtist: "Ngọt", songURL: "album2"),
                     Song(songImage: "album3", songName: "Album 3", songArtist: "Ngọt", songURL: "album3"),
                     Song(songImage: "album4", songName: "Album 4", songArtist: "Ngọt", songURL: "album4")]
        
        _ = songs.map { songList.append($0) }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellId") as? TableViewCell else
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCellId")
            return cell
        }
        
        let thisSong = songList[indexPath.row]
        tableViewCell.config(thisSong: thisSong)
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSegue"){
            let indexPath = self.songTableView.indexPathForSelectedRow!
            let songDetailView = segue.destination as? ViewController
            let selectedSong = songList[indexPath.row]
            songDetailView?.selectedSong = selectedSong
            self.songTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
