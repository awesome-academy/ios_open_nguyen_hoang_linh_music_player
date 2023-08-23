//
//  ViewController.swift
//  MusicApp
//
//  Created by Hoang Linh Nguyen on 22/8/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var playButton: UIButton!
    private var isPlaying : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        var imageSystemName : String
        isPlaying ? (imageSystemName = "play.circle.fill") : (imageSystemName = "pause.circle.fill")
        isPlaying = !isPlaying

        sender.setImage(UIImage(systemName: imageSystemName), for: .normal)
    }
}

