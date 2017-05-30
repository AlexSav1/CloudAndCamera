//
//  ImageCollectionViewCell.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/15/17.
//
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
