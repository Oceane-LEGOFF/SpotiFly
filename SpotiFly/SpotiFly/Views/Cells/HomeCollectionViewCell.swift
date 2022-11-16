//
//  HomeCollectionViewCell.swift
//  SpotiFly
//
//  Created by Axel Demorest on 16/11/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistTrackName: UILabel!
    @IBOutlet weak var artistName: UILabel!

    @IBOutlet weak var artistTrackCover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
