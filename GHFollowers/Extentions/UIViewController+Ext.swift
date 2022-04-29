//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/30/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit

fileprivate var containerView : UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoading(){
        containerView = UIView(frame: view.bounds)
        
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicaror = UIActivityIndicatorView(style: .large)

        activityIndicaror.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicaror)
        
        NSLayoutConstraint.activate([
            activityIndicaror.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicaror.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicaror.startAnimating()
    }
    
    
    func dismessLoading(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyState(with message : String,view:UIView){
        let emptyStateView = GFEmptyState(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
