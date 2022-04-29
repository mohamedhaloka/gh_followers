//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 05/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let resuableId = "followerCell"

    let avatarImg = GFAvatarImage(frame: .zero)
    
    let usernameTitle = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        congfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Follower){
        usernameTitle.text = follower.login
        avatarImg.downloadImage(from: follower.avatarUrl)
    }
    
    
    private func congfigure(){
        addSubview(avatarImg)
        addSubview(usernameTitle)
        
        let padding :CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImg.widthAnchor.constraint(equalToConstant: 100),
            avatarImg.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            
            usernameTitle.topAnchor.constraint(equalTo: avatarImg.bottomAnchor, constant: 12),
            usernameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
