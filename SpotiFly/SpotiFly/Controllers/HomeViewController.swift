//
//  HomeViewController.swift
//  SpotiFly
//
//  Created by Axel Demorest on 16/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    var tracks: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        HomeCollectionView.dataSource = self
        HomeCollectionView.delegate = self
        
       
        ApiManager().fetchTracksFromAlbumId(id: 211985622) { tracks, error in
            self.tracks = tracks
            
            DispatchQueue.main.async {
                self.HomeCollectionView.reloadData()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HomeCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        cell.artistTrackCover.downloaded(from: tracks[indexPath.row].albumCover)
        cell.artistName.text = tracks[indexPath.row].artistName
        cell.artistTrackName.text = tracks[indexPath.row].titleSong
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playerViewId") as? PlayerViewController {
            
            vc.trackAlbumCover = tracks[indexPath.row].albumCover
            vc.trackName = tracks[indexPath.row].titleSong
            vc.trackPreview = tracks[indexPath.row].preview
            vc.trackArtistName = tracks[indexPath.row].artistName
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
    



// Extension
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

