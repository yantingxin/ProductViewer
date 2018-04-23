//
//  RatingControl.swift
//  ProductViewer
//
// A simple star rating implementation by taking advantage of button statuses.
// It only supports whole star rating now.
//
//  Created by Terry Yan on 4/22/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    private var ratingList = [UIButton]()
    var rating = 0
    @IBInspectable var starSize: CGSize = CGSize(width: 20.0, height: 20.0) {
        didSet { setupRatings() }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet { setupRatings() }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupRatings() {
        self.backgroundColor = UIColor.white
        for star in ratingList {
            removeArrangedSubview(star)
            star.removeFromSuperview()
        }
        ratingList.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named:"starEmpty", in: bundle, compatibleWith: self.traitCollection)
        let fullStar  = UIImage(named:"starFull",  in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            let star = UIButton()
            star.setImage(emptyStar, for: .normal)
            star.setImage(fullStar,  for: .selected)
            star.isUserInteractionEnabled = false   // we don't allow user input rating in this case.
            
            addArrangedSubview(star)
            ratingList.append(star)
        }
    }
    
    public func setRating(rating: Int) {
        self.rating = rating
        for i in 0..<rating {
            ratingList[i].isSelected = true
        }
     }
}
