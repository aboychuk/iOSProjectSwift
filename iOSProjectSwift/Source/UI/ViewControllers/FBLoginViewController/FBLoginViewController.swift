//
//  FBLoginViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBLoginViewController : FBViewController, RootView {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBloginView
    
    //MARK: - IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        self.context = Context(model: self.currentUser)
    }
    
    //MARK: - Public functions
    
    override func updateWithModel(_ model: Model) {
        self.showUserDetailViewController()
    }
    
    //MARK: - Private Functions
    
    private func showUserDetailViewController() {
        let detailController = FBUserDetailController()
        detailController.model = self.model
        detailController.currentUser = self.currentUser
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
}
