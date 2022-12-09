//
//  resultsTableViewCell.swift
//  CardBoard
//
//  Created by Divyansh Singh on 08/12/22.
//

import UIKit

class resultsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImages: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var rewardsValue: UILabel!
    //@IBOutlet weak var rewardsType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
