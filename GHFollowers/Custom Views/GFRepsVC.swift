//
//  GFRepsVC.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 20/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFRepoVC : GFUserInfoItem{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemTypeOne.set(itemType: .repo, with: user.publicRepos)
        itemTypeTwo.set(itemType: .gists, with: user.publicGists)
        btn.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func btnOnTap() {
        delegate.onTapGithubProfile(for: user)
    }
    
}
