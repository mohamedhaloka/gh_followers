//
//  FavouriteCell.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 26/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseId = "FavouriteCell"
    let avatar = GFAvatarImage(frame: .zero)
    let username = GFTitleLabel(textAlignment: .left, fontSize: 28)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite : Follower){
        avatar.downloadImage(from: favourite.avatarUrl)
        username.text = favourite.login
    }
    
    private func configure(){
        addSubview(avatar)
        addSubview(username)
        
        accessoryType = .disclosureIndicator
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatar.heightAnchor.constraint(equalToConstant: 60),
            avatar.widthAnchor.constraint(equalToConstant: 60),
            
            username.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            username.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 24),
            username.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            username.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
