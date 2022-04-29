//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/27/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favorites : [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseId)
    }
    
    
    func getFavorites(){
        PersistanceManager.retriveFavourites { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch (result) {
            case .success(let followers):
                print(followers)
                if (followers.isEmpty){
                    self.showEmptyState(with: "No Favorite Followers Yet", view: self.view)
                } else {
                    self.favorites = followers
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                
                break
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
}

extension FavoritesListVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseId) as! FavouriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favourite: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC()
        destVC.username = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.update(favorite: favorite, persistanceAction: .remove) { [weak self] error in
            guard let self = self else { return  }
            guard let error = error else { return }
            self.presentGFAlertOnMainThread(title: "Unable to remove from Fav", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
}
