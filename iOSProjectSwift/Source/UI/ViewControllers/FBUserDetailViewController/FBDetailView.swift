//
//  FBDetailView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/30/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBDetailView: BaseView {
    
    //MARK: - Properties
    
    @IBOutlet var friendsButton: UIButton?
    @IBOutlet var imageView: ImageView?
    @IBOutlet var userFullName: UILabel?
    
    //MARK: - Public functions
    
    func fillWithModel(_ model: FBUser) {
        self.userFullName?.text = model.fullname
        self.imageView?.imageModel = model.imageModel
    }
}
