//
//  GFFollowerVC.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 20/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFFollowerVC : GFUserInfoItem{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems(){
        itemTypeOne.set(itemType: .followers, with: user.followers)
        itemTypeTwo.set(itemType: .following, with: user.following)
        btn.set(backgroundColor: .systemGreen, title: "Followers")
    }
    
    override func btnOnTap() {
        delegate.onTapGetFollowers(for: user)
    }
    
}
