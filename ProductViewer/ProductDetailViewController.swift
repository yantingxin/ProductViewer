//
//  ViewController.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/20/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var ratingView : RatingControl!
    
    var product :Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateProduct()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func populateProduct() {
        name?.text = product.name
        ratingView.setRating(rating: Int(round(product.review)))
        count?.text  = String("(\(product.reviewCount))")
        price?.text  = String("$\(product.price.format(format: ".2"))") 
        
        if product.status {
            status?.text = "In stock"
            status?.textColor = brightBlue
        } else {
            status?.text = "Out of stock"
            status?.textColor = UIColor.red
        }
        desc?.attributedText = product.longDesc.htmlToAttributedText
        image?.image = product.image
    }

}

