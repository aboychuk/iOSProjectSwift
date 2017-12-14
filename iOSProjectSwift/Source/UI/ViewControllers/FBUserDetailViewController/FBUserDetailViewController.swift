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
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let loadingView = self.rootView?.loadingView
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                loadingView?.set(visible: false)
                self?.dismiss(animated: true, completion: nil)
            }
            
            self.observationController?[.willLoad] = { _, _ in
                loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak self] _, _ in
                loadingView?.set(visible: false)
                guard let model = self?.model else { return }
                self?.updateWithModel(model)
            }
        }
    }
    
    var logoutContext: FBLogoutContext? {
        didSet {
            oldValue?.cancel()
            self.logoutContext?.execute()
        }
    }
    
    //MARK: - Private properties
    
    private var userModel: FBUserModel? {
        return self.model as? FBUserModel
    }
    
    //MARK: - Initializations
    
    init(model: FBCurrentUserModel) {
        super.init(nibName: toString(from: FBUserDetailController.self), bundle: .main)
        
        
        self.currentUser = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - IBActions
    
    @IBAction func onFriends(sender: UIButton) {
        self.showFriendsViewController()
    }
    
    @IBAction func onLogout(sender: UIButton) {
        self.logoutContext = FBLogoutContext(model: self.currentUser)
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationItem()
        self.context = FBUserDetailContext(model: self.model)
    }
    
    //MARK: - Public functions
    
    func updateWithModel(_ model: Model) {
        guard let userModel = self.userModel else { return }
        self.rootView?.fillWithModel(userModel)
    }
    
    //MARK: - Private functions
    
    private func prepareNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(onLogout(sender:)))
    }
    
    private func showFriendsViewController() {
        let friendsController = FBFriendsViewController.init(model: self.currentUser)
        
        if let userFriends = self.userModel?.friends {
            friendsController.model = userFriends
        }
        
        let navigationController = UINavigationController(rootViewController: friendsController)
        self.navigationController?.pushViewController(navigationController, animated: true)
    }
}
