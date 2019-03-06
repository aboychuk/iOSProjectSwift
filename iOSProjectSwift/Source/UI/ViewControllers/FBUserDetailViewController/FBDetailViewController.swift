//
//  FBUserDetailViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBDetailViewController: FBViewController, RootView {
    typealias ViewType = FBDetailView
    
    //MARK: - Properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let loadingView = self.rootView?.loadingView
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
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
    
    private var userModel: FBUser? {
        return self.model as? FBUser
    }
    
    //MARK: - Initializations
    
    init(model: FBUser, currentUser: FBCurrentUser) {
        super.init(nibName: typeString(FBDetailViewController.self), bundle: .main)
        
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
        self.userModel.map { self.rootView?.fillWithModel($0) }
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
