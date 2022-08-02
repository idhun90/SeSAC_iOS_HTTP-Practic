//
//  ListTableViewCell.swift
//  practiceSearchMovieData
//
//  Created by 이도헌 on 2022/08/02.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var audiAccLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        releaseLabel.font = .systemFont(ofSize: 15)
        rankLabel.font = .systemFont(ofSize: 15)
        audiAccLabel.font = .systemFont(ofSize: 15)
        
        titleLabel.numberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
