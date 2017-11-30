//
//  FBUserDetailViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserDetailController : FBViewController {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBUserDetailView
    
    //MARK: - Properties
    
    var logoutContext: FBLogoutContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    //MARK: - IBActions
    
    @IBAction func onFriends(sender: UIButton) {
        self.showFriendsViewController()
    }
    
    @IBAction func onLogout(sender: UIButton) {
        if let currentUser = self.currentUser {
            self.logoutContext = FBLogoutContext(model: currentUser)
        }
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationItem()
        if let model = self.model {
            self.context = FBUserDetailContext(model: model)
        }
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
        //show next VC
    }
    
    //MARK: - ModelObserver protocol
    
    override func didUnload(model: Model) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView?.loadingView?.set(visible: false)
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
