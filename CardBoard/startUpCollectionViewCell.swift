//
//  startUpCollectionViewCell.swift
//  CardBoard
//
//  Created by Divyansh Singh on 02/11/22.
//

import UIKit

class startUpCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: startUpCollectionViewCell.self)
    @IBOutlet weak var slideImageView: UIImageView!
    func setup(_ slide: onBoardingSlide)
    {
        slideImageView.image = slide.image
    }
}
