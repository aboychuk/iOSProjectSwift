//
//  FBUserDetailViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserDetailController : FBViewController, RootView {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBUserDetailView
    
    //MARK: - Public Properties
    
    var logoutContext: FBLogoutContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    //MARK: - Private properties
    
    var fbUserModel: FBUserModel? {
        return self.model as? FBUserModel
    }
    
    //MARK: - IBActions
    
    @IBAction func onFriends(sender: UIButton) {
        self.showFriendsViewController()
    }
    
    @IBAction func onLogout(sender: UIButton) {
            self.logoutContext = FBLogoutContext(model: currentUser)
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationItem()

            self.context = FBUserDetailContext(model: model)
    }
    
    //MARK: - Public functions
    
    override func updateWithModel(_ model: Model) {
        //rootview.updateWithModel
    }
    
    //MARK: - Private functions
    
    private func prepareNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(onLogout(sender:)))
    }
    
    private func showFriendsViewController() {
        let friendsController = FBFriendsViewController()
//        friendsController.model = self.model.friends
        friendsController.currentUser = self.currentUser
        let navigationController = UINavigationController.init(rootViewController: friendsController)
        
        self.present(navigationController, animated: true, completion: nil)

    }
}
