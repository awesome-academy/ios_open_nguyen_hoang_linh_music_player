//
//  ViewController.swift
//  MusicApp
//
//  Created by Hoang Linh Nguyen on 22/8/2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songArtist: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    private var isPlaying = false
    var selectedSong : Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedSong = selectedSong{
            songImage.image = UIImage(named: selectedSong.songImage)
            songName.text = selectedSong.songName
            songArtist.text = selectedSong.songArtist
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        var imageSystemName : String
        isPlaying ? (imageSystemName = "play.circle.fill") : (imageSystemName = "pause.circle.fill")
        isPlaying = !isPlaying
        sender.setImage(UIImage(systemName: imageSystemName), for: .normal)
    }
}

