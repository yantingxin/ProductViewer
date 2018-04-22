//
//  RatingControl.swift
//  ProductViewer
//
//  Created by Terry Yan on 4/22/18.
//  Copyright © 2018 Terry Yan. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    @IBInspectable var starSize: CGSize = CGSize(width: 20.0, height: 20.0) {
        didSet { setupButtons() }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet { setupButtons() }
    }
    
//    private var starList = [UIImageView]()
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupButtons() {
        self.backgroundColor = UIColor.white
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named:"starEmpty", in: bundle, compatibleWith: self.traitCollection)
        let fullStar  = UIImage(named:"starFull",  in: bundle, compatibleWith: self.traitCollection)
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = false
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = false
            button.setImage(emptyStar, for: .normal)
            button.setImage(fullStar,  for: .selected)
            button.isUserInteractionEnabled = false
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    public func setRating(rating: Int) {
        self.rating = rating
        for i in 0..<rating {
            ratingButtons[i].isSelected = true
        }
     }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
