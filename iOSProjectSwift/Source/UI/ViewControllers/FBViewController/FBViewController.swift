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
    
    var model: Model = FBUser() {
        didSet { self.observationController = self.model.controller(for: self) }
    }
    
    var currentUser: FBCurrentUser = FBCurrentUser() {
        didSet { self.observationController = self.currentUser.controller(for: self) }
    }
    
    var context: Context? {
        willSet {
            self.context?.cancel()
            newValue?.execute()
        }
    }
}
