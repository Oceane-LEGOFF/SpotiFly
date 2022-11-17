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
        
        do {
            audioPlayer = try AVPlayer(url: url as URL)
        } catch {
            print("Une erreur est survenue avec le fichier audio")
        }
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        
        playButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: largeConfig), for: .normal)
        
        audioPlayer!.play()
        
        trackOutletCover.downloaded(from: trackAlbumCover)
        trackOutletName.text = trackName
        trackOutletArtistName.text = trackArtistName
    }
}
