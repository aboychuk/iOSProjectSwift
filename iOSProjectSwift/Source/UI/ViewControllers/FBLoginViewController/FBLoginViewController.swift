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
            
            self.observationController?[.didUnload] = { [weak loadingView] _, _ in
                loadingView?.set(visible: false)
            }
            
            self.observationController?[.willLoad] = { [weak self] _, _ in
                self?.showUserDetailViewController()
                loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak loadingView] _, _ in
                loadingView?.set(visible: false)
            }
        }
    }
    
    //MARK: - Initializations
    
    init(currentUser: FBCurrentUserModel) {
        super.init(nibName: toString(FBLoginViewController.self), bundle: .main)
        
        self.currentUser = currentUser
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        self.context = FBLoginContext(model: self.currentUser)
    }
    
    //MARK: - Private Functions
    
    private func showUserDetailViewController() {
        let model = self.currentUser
        let detailController = FBUserDetailController(model: model, currentUser: self.currentUser)
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true)
    }
}
