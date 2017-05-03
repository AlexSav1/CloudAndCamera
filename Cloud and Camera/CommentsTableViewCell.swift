//
//  CommentsTableViewCell.swift
//  Cloud and Camera
//
//  Created by Aditya Narayan on 3/27/17.
//
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var customTextLabel: UILabel!
    
    func setText(text: String){
        self.customTextLabel.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
