//
//  FBViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, RootView {
    
    //MARK: - RootView protocol
    
    typealias ViewType = BaseView
    
    //MARK: - Properties
    
    var observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.rootView?.loadingView?.set(visible: false)
            }
            
            self.observationController?[.willLoad] = { [weak self] _, _ in
                self?.rootView?.loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak self] _, _ in
                self?.rootView?.loadingView?.set(visible: false)
                //Update with model
            }
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.rootView?.loadingView?.set(visible: false)
            }
        }
    }
    
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
