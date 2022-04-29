//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 15/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit
import SafariServices


protocol UserInfoDelegate : AnyObject {
    func onTapGithubProfile(for user : User)
    func onTapGetFollowers(for user : User)
}

class UserInfoVC: UIViewController {
    let header = UIView()
    let viewOne = UIView()
    let viewTwo = UIView()
    let accDate = GFBodyLabel(textAlignment: .center)
    var views : [UIView] = []
    
    var delegate : FollowerListVCDelegate!
    
    var username:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        UILayout()
        getUserInfo()
    }
    
    func configureVC(){
        view.backgroundColor = .systemBackground
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = doneBtn
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserData(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let user):
                print(user)
                DispatchQueue.main.async {
                    self.configureUser(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Erorr Occured", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUser(with user : User){
        let repoVC = GFRepoVC(user: user)
        repoVC.delegate = self
        
        let followersVC = GFFollowerVC(user: user)
        followersVC.delegate = self
        
        self.addChildVC(childVC: GFUserInfoHeader(userInfo: user), container: self.header)
        self.addChildVC(childVC: repoVC, container: self.viewOne)
        self.addChildVC(childVC: followersVC, container: self.viewTwo)
        self.accDate.text = "Github since \(user.createdAt.convertToReadableDate())"
    }
    
    @objc func dismissView(){
        dismiss(animated: true)
    }
    
    
    func UILayout(){
        let padding : CGFloat = 20
        let itemSpacing : CGFloat = 80
        let itemHeight : CGFloat = 140
        views = [header,viewOne,viewTwo,accDate]
        
        for item in views {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor,constant: 45),
            header.heightAnchor.constraint(equalToConstant: 100),
            
            viewOne.topAnchor.constraint(equalTo: header.bottomAnchor, constant: itemSpacing),
            viewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            viewTwo.topAnchor.constraint(equalTo: viewOne.bottomAnchor, constant: padding),
            viewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            accDate.topAnchor.constraint(equalTo: viewTwo.bottomAnchor, constant: padding),
            accDate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    func addChildVC(childVC : UIViewController , container : UIView){
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }

}

extension UserInfoVC : UserInfoDelegate {
    func onTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL Profile", message: "url profile for this user is invalid", buttonTitle: "OK")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func onTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Has Zero Followers", message: "this user does not have any followers", buttonTitle: "Ok")
            return
        }
        
        delegate.onRequestNewUserFollower(for: user)
        dismissView()
    }
    
   
}
