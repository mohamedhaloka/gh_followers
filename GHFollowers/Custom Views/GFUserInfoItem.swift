//
//  GFUserInfoItem.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 20/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import UIKit

class GFUserInfoItem: UIViewController {
    
    let stackView  = UIStackView()
    let itemTypeOne = ItemInfoView()
    let itemTypeTwo = ItemInfoView()
    let btn = GFButton()
    var delegate : UserInfoDelegate!
    
    var user : User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItemView()
        configureBtnTapped()
        UILayout()
        configureStackView()
    }
    
    private func configureItemView(){
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
    }
    
    func configureBtnTapped() {
        btn.addTarget(self, action: #selector(btnOnTap), for: .touchUpInside)
    }
    
    @objc func btnOnTap(){}
    
    private func UILayout(){
        view.addSubview(stackView)
        view.addSubview(btn)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            
            btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            btn.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemTypeOne)
        stackView.addArrangedSubview(itemTypeTwo)
    }

}
