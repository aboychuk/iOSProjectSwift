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
        super.init()
        self.currentUser = FBCurrentUserModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
