//
//  Product.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/21/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit
import Foundation

class Product {
    var id: String
    var imageUrl: URL
    var name: String
    var status: Bool
    var price: Double
    var review: Double
    var reviewCount: Int
    var shortDesc: String
    var longDesc: String
    var image: UIImage?
        
    init(id: String, name: String, status: Bool, price: Double, review: Double, reviewCount: Int, shortDesc: String, longDesc: String, imageUrl: URL) {
        self.id     = id
        self.name   = name
        self.status = status
        self.price  = price
        self.review = review
        self.reviewCount = reviewCount
        self.shortDesc = shortDesc
        self.longDesc  = longDesc
        self.imageUrl  = imageUrl
    }
    
    public func setImage(image: UIImage) {
        self.image = image;
    }
}
