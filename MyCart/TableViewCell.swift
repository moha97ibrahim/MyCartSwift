//
//  TableViewCell.swift
//  MyCart
//
//  Created by Mohammed Ibrahim on 3/7/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "TableViewCell" 
    
    static func nib() -> UINib{
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    public func configure (with images: String, name: String ){
        myImages.image = UIImage(named: images)
        myName.text = name
    }
    
    @IBOutlet var myImages: UIImageView!
    @IBOutlet var myName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
