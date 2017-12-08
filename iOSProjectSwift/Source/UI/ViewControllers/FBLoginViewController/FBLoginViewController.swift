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
    
    // MARK: - Properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let loadingView = self.rootView?.loadingView
        
            self.observationController?[.willLoad] = { [weak self] _, _ in
                loadingView?.set(visible: true)
                self?.showUserDetailViewController()
            }
        }
    }
    
    //MARK: - Initializations
    
    init(model: FBCurrentUserModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.currentUser = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        self.context = FBLoginContext(model: self.currentUser)
    }
    
    //MARK: - Private Functions
    
    private func showUserDetailViewController() {
        let detailController = FBUserDetailController()
        detailController.model = self.currentUser
        detailController.currentUser = self.currentUser
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true)
    }
}
