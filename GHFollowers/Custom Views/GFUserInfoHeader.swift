//
//  GFUserInfoHeader.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 16/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFUserInfoHeader: UIViewController {
    
    let profileImage    = GFAvatarImage(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontSize: 32)
    let nameLabel       = GFSecondaryLabel(fontSize: 14)
    let locationImage   = UIImageView()
    let locationLabel   = GFSecondaryLabel(fontSize: 14)
    let bioLabel        = GFBodyLabel(textAlignment: .left)
    
    
    var user : User!
    
    init(userInfo : User) {
        super.init(nibName: nil, bundle: nil)
        user = userInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        UILayout()
        configureUIElements()
    }
    
    func configureUIElements(){
        profileImage.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImage.image = UIImage(systemName: "location")
        locationImage.tintColor = .secondaryLabel
        locationLabel.text = user.location ?? ""
        bioLabel.text = user.bio ?? ""
        bioLabel.numberOfLines = 3
    }
    
    
    func addViews(){
        view.addSubview(profileImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImage)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    
    func UILayout(){
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 12
        let imagePadding : CGFloat =  8
        
        
        NSLayoutConstraint.activate([
        ///Avatar Image
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
        ///Username Label
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: imagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ///Name Label
            nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: imagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ///Location Image
            locationImage.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 0),
            locationImage.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: imagePadding),
            locationImage.widthAnchor.constraint(equalToConstant: 18),
            
        ///Location Label
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor, constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 4),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ///Bio Label
            bioLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 0),
            bioLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 66)

        
        ])
        
        
    }
    
}
