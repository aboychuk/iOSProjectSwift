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
        
    }
    
    @IBAction func onLogout(sender: UIButton) {
        
    }
    
    //MARK: View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationItem()
        if let model = self.model {
            self.context = FBUserDetailContext.init(model: model)
        }
    }
    
    //MARK: Public functions
    
    func updateWithModel(_ model: Model) {
//        self.rootView.fillWithModel
    }
    
    //MARK: Private functions
    
    private func prepareNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(onLogout(sender:)))
    }
}
