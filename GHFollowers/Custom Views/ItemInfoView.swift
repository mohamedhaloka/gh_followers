//
//  ItemInfoView.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 18/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

enum ItemInfoType {
    case repo , gists , followers , following
}

class ItemInfoView: UIView {

    let symbolsImage = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 18)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 18)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolsImage)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolsImage.translatesAutoresizingMaskIntoConstraints = false
        symbolsImage.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolsImage.topAnchor.constraint(equalTo: self.topAnchor),
            symbolsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolsImage.heightAnchor.constraint(equalToConstant: 20),
            symbolsImage.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolsImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolsImage.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            countLabel.topAnchor.constraint(equalTo: symbolsImage.bottomAnchor),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    
    func set ( itemType : ItemInfoType, with count : Int){
        switch itemType {
        case .repo:
            symbolsImage.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
        case .gists:
            symbolsImage.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
        case .followers:
            symbolsImage.image = UIImage(systemName: "heart")
            titleLabel.text = "Followers"
        case .following:
            symbolsImage.image = UIImage(systemName: "person")
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
