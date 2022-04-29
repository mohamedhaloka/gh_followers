//
//  GFSecondaryLabel.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 16/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFSecondaryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(fontSize : CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    
    func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        lineBreakMode = .byTruncatingTail
        minimumScaleFactor = 0.90
        adjustsFontSizeToFitWidth = true
    }
}
