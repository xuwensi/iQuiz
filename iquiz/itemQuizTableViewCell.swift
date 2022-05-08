//
//  itemQuizTableViewCell.swift
//  iquiz
//
//  Created by Wensi Xu on 5/7/22.
//

import UIKit

class itemQuizTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
