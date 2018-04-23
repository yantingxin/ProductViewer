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
    
    var products :[Product]!
    var currentIndex :Int!
    var productModel: ProductModel!
    
    @objc func respondToSwipeGesture (gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right :
                if currentIndex > 0 {
                    currentIndex = currentIndex - 1
                    populateProduct(product: products[currentIndex])
                }
            case UISwipeGestureRecognizerDirection.left :
                if currentIndex < products.count - 1 {
                    currentIndex = currentIndex + 1
                    populateProduct(product: products[currentIndex])
                    fetchNextImage(index: currentIndex+1)
                }
            default:
                print("Swiped unknown direction")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disable navigator's gesture recognizer to avoid confusion
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        populateProduct(product: products[currentIndex])
        fetchNextImage(index: currentIndex+1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func fetchNextImage(index: Int) {
        if index >= 0 && index < products.count && products[index].image == nil {
            productModel.fetchImage(url: products[index].imageUrl, index: index, completionHandler: updateImage)
        }
    }
    
    private func updateImage(index: Int, image: UIImage?) {
        products[index].setImage(image: image!)
    }
    
    private func populateProduct(product: Product) {
        name?.text = product.name
        name?.textColor = brightBlue
        ratingView.setRating(rating: Int(round(product.review)))
        count?.text  = String("(\(product.reviewCount))")
        price?.text  = String("$\(product.price.format(format: ".2"))")
        desc?.attributedText = product.longDesc.htmlToAttributedText
        
        if product.status {
            status?.text = "In stock"
            status?.textColor = brightBlue
        } else {
            status?.text = "Out of stock"
            status?.textColor = UIColor.red
        }
        
        if product.image == nil {
            image?.image = UIImage(named: "default")
        } else {
            image?.image = product.image
        }
    }

}

