//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/30/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit


protocol FollowerListVCDelegate : AnyObject {
    func onRequestNewUserFollower(for user : User)
}

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var pageNum = 1
    var hasMoreData = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    
    var followersCollection :[Follower] = []
    var followersFilter :[Follower] = []

    var dataSource : UICollectionViewDiffableDataSource<Section,Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchBar()
        configurecollectionView()
        getFollowers(username: username, pageNum: pageNum)
        configureCollectionDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
        navigationItem.rightBarButtonItem = addBtn
    }
    
    func configurecollectionView(){
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.resuableId)

    }
    
    func getFollowers(username : String , pageNum : Int) {
        showLoading()
        
        NetworkManager.shared.getFollowers(for: username, pageNum: pageNum) {[weak self] result in
            guard let self = self  else{
                return
            }
            self.dismessLoading()
            
            switch result{
            case .success(let followers):
                print(followers)
                if( followers.count < 100){self.hasMoreData = false}
                self.followersCollection.append(contentsOf: followers)
                
                if self.followersCollection.isEmpty {
                    let message = "This user doesn't have any followers, please follow him 🥲"
                    DispatchQueue.main.async {
                        self.showEmptyState(with: message, view: self.view)
                    }
                    return
                }
                
                self.updateData(in:self.followersCollection)

            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Status Here", message: error.rawValue , buttonTitle: "OK")

            }
        }
    }
    
    
    func configureCollectionDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.resuableId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func configureSearchBar(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func updateData(in follower : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follower)
        DispatchQueue.main.async{
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func addBtnTapped(){
        NetworkManager.shared.getUserData(for: username) { [weak self] result in
            guard let self = self else {
                return
            }
            switch (result){
            case .success(let user):
                let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistanceManager.update(favorite: favourite, persistanceAction: .add) { [weak self] error in
                    guard let self = self else {
                        return
                    }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Add to Favourite", message: "Congrats you add this user to favourite", buttonTitle: "Haaay")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "User is exist", message: error.rawValue, buttonTitle: "OK")
                }
                
                break;
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "OK")
                break;
            }
        }
    }
}

extension FollowerListVC : UICollectionViewDelegate{
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yHeight = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.bounds.height
        
        print("yHeight => \(yHeight)")
        print("contentHeight => \(contentHeight)")
        print("screenHeight => \(screenHeight)")
        print(screenHeight + yHeight)
        
        if yHeight > (contentHeight - screenHeight)
        {
            if hasMoreData == false { return }
            pageNum += 1
            getFollowers(username: username, pageNum: pageNum)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? followersFilter : followersCollection
        let follower = activeArray[indexPath.row];
        
        let desVC = UserInfoVC()
        desVC.username = follower.login
        desVC.delegate = self
        let navigationBar = UINavigationController(rootViewController: desVC)
        present(navigationBar, animated: true)
        
    }
}

extension FollowerListVC : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else{
            return;
        }
        isSearching = true;
         followersFilter = followersCollection.filter({$0.login.lowercased().contains(filter.lowercased())})
        updateData(in: followersFilter)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(in: followersCollection)
    }
}

extension FollowerListVC : FollowerListVCDelegate{
    func onRequestNewUserFollower(for user: User) {
        username = user.login
        title = username
        followersFilter.removeAll()
        followersCollection.removeAll()
        pageNum = 0
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, pageNum: pageNum)
    
    }
    
    
}
