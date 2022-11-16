//
//  SearchTableViewCell.swift
//  SpotiFly
//
//  Created by Axel Demorest on 16/11/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var artistPicture: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
