//
//  ViewController.swift
//  MusicApp
//
//  Created by Hoang Linh Nguyen on 22/8/2023.
//

import UIKit
import AVFoundation
import MediaPlayer

final class ViewController: UIViewController {
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songArtist: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    
    private var audioPlayer: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var songURL : URL?
    private var isPlaying = false
    var selectedSong : Song?
    private let commandCenter = MPRemoteCommandCenter.shared();
    private var commandPlay: Any?
    private var commandPause: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedSong = selectedSong{
            songImage.image = UIImage(named: selectedSong.songImage)
            songName.text = selectedSong.songName
            songArtist.text = selectedSong.songArtist
            if let path = Bundle.main.path(forResource: selectedSong.songURL, ofType:"mp3") {
                songURL = URL(filePath: path)
            }
        }
        
        if let songURL = songURL {
            playerItem = AVPlayerItem(url: songURL)
            audioPlayer = AVPlayer(playerItem: playerItem)
            setupAudioSession()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
        commandCenter.playCommand.isEnabled = false
        commandCenter.playCommand.removeTarget(commandPlay)
        commandCenter.pauseCommand.isEnabled = false
        commandCenter.pauseCommand.removeTarget(commandPause)
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting the AVAudioSession:", error.localizedDescription)
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        var imageSystemName : String
        isPlaying ? (
            imageSystemName = "play.circle.fill",
            self.audioPlayer?.pause()
        ) : (
            imageSystemName = "pause.circle.fill",
            self.audioPlayer?.play()
        )
        setupNowPlaying()
        setupRemoteCommandCenter()
        isPlaying.toggle()
        sender.setImage(UIImage(systemName: imageSystemName), for: .normal)
    }
    
    
    private func setupNowPlaying() {
        var nowPlayingInfo = [String: Any]()
        if let selectedSong = selectedSong {
            nowPlayingInfo[MPMediaItemPropertyTitle] = selectedSong.songName
            nowPlayingInfo[MPMediaItemPropertyArtist] = selectedSong.songArtist
            if let image = UIImage(named: selectedSong.songImage){
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (size) -> UIImage in
                    return image
                })
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = playerItem?.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = playerItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer?.rate
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
    }
    
    private func setupRemoteCommandCenter() {
        commandCenter.playCommand.isEnabled = true
        commandPlay = commandCenter.playCommand.addTarget {event in
            self.audioPlayer?.play()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandPause = commandCenter.pauseCommand.addTarget {event in
            self.audioPlayer?.pause()
            return .success
        }
    }
}

