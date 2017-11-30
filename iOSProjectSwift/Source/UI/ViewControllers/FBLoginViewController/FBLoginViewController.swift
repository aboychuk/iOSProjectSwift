//
//  FBLoginViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBloginViewController : FBViewController {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBloginView
    
    //MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: .main)
        self.currentUser = FBCurrentUserModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        if let model = self.currentUser {
            self.context = Context.init(model: model)
        }
    }
    
    //MARK: - Public functions
    
    override func updateWithModel(_ model: Model) {
        self.showUserDetailViewController()
    }
    
    //MARK: - Private Functions
    
    private func showUserDetailViewController() {
        //Create next VC
    }
    
    //MARK: - ModelObserver protocol
    
    override func willLoad(model: Model) {
        DispatchQueue.main.async { [weak self] in
            self?.updateWithModel(model)
        }
    }
}
