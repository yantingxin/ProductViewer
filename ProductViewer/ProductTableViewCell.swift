//
//  ProductTableViewCell.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/21/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var ratingView: RatingControl! = RatingControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
