//
//  PlayerViewController.swift
//  SpotiFly
//
//  Created by Axel Demorest on 16/11/2022.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var trackAlbumCover: String = ""
    var trackName: String = ""
    var trackPreview: String = ""
    var trackArtistName: String = ""
    var tracksInAlbum: [Song] = []
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var trackOutletCover: UIImageView!
    @IBOutlet weak var trackOutletName: UILabel!
    @IBOutlet weak var trackOutletArtistName: UILabel!
    
    var audioPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: trackPreview) else {
            print("Impossible de lire le fichier MP3")
            return
        }
        
        audioPlayer = AVPlayer(url: url as URL)

        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        
        playButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig)?.withTintColor(.black, renderingMode: UIImage.RenderingMode.alwaysOriginal), for: .normal)
        
        audioPlayer!.play()
        
        trackOutletCover.downloaded(from: trackAlbumCover)
        trackOutletName.text = trackName
        trackOutletArtistName.text = trackArtistName
    }
    @IBAction func playButton(_ sender: UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        
        if audioPlayer?.rate == 0
            {
                audioPlayer!.play()
                playButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig)?.withTintColor(.black, renderingMode: UIImage.RenderingMode.alwaysOriginal), for: .normal)
            } else {
                audioPlayer!.pause()
                playButton.setImage(UIImage(systemName: "play.fill", withConfiguration: largeConfig)?.withTintColor(.black, renderingMode: UIImage.RenderingMode.alwaysOriginal), for: .normal)
            }
    }
}
