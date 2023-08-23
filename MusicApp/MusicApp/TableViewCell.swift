//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Hoang Linh Nguyen on 23/8/2023.
//

import UIKit

final class TableViewCell : UITableViewCell{
    @IBOutlet private weak var songImage: UIImageView!
    @IBOutlet private weak var songName: UILabel!
    @IBOutlet private weak var songArtist: UILabel!
    
    func config(thisSong: Song){
        songImage.image = UIImage(named: thisSong.songImage)
        songName.text = thisSong.songName
        songArtist.text = thisSong.songArtist
    }
}
