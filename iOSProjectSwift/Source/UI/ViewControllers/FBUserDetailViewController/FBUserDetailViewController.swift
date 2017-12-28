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
            
//            self.observationController?[.didUnload] = { [weak self] _, _ in
//                loadingView?.set(visible: false)
//                self?.dismiss(animated: true, completion: nil)
//            }
            
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
    
    init(model: FBUserModel, currentUser: FBCurrentUserModel) {
        super.init(nibName: toString(FBUserDetailController.self), bundle: .main)
        
        self.model = model
        self.currentUser = currentUser
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
        guard let userFriends = self.userModel?.friends else { return }
        
        let friendsController = FBFriendsViewController(model: userFriends, currentUser: self.currentUser)

        self.navigationController?.pushViewController(friendsController, animated: true)
    }
}
