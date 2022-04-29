//
//  GFEmptyState.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 11/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFEmptyState: UIView {
    
    var labelTxt = GFTitleLabel(textAlignment: .center, fontSize: 22)
    var imageView = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(message : String) {
        super.init(frame: .zero)
        labelTxt.text = message
        configure()
    }
    
    private func configure(){
        addSubview(labelTxt)
        addSubview(imageView)
        
        labelTxt.numberOfLines = 3
        labelTxt.textColor = .secondaryLabel
        
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTxt.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            labelTxt.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            labelTxt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            labelTxt.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
    }
    
}
