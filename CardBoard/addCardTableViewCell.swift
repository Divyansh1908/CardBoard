//
//  addCardTableViewCell.swift
//  CardBoard
//
//  Created by Divyansh Singh on 01/12/22.
//

import UIKit

class addCardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!

    @IBOutlet weak var cardInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
