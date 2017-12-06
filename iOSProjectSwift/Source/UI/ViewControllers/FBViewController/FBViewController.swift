//
//  FBViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBViewController: UIViewController  {
    
    //MARK: - Properties
    
    var observationController: ObservableObject.ObservationController?
    
    var model: Model = FBUserModel() {
        didSet { self.observationController = self.model.controller(for: self) }
    }
    
    var currentUser: FBCurrentUserModel = FBCurrentUserModel() {
        didSet { self.observationController = self.currentUser.controller(for: self) }
    }
    
    var context: Context? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    //MARK: - Functions for overriding
    
    func updateWithModel(_ model: Model) {

    }
}
