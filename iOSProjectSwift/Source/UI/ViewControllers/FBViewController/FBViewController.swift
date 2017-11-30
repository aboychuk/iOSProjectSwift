//
//  FBViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, RootView, ModelObserver {
    
    //MARK: - RootView protocol
    
    typealias ViewType = BaseView
    
    //MARK: - Properties
    
    var model: Model? {
        willSet { newValue?.add(observer: self) }
        didSet { oldValue?.remove(observer: self) }
    }
    
    var context: Context? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    var currentUser: FBCurrentUserModel? {
        willSet { newValue?.add(observer: self) }
        didSet { oldValue?.remove(observer: self) }
    }
    
    //MARK: - ModelObserver protocol
    
    func didUnload(model: Model) {
        
    }
    
    func willLoad(model: Model) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView?.loadingView?.set(visible: true)
        }
    }
    
    func didLoad(model: Model) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView?.loadingView?.set(visible: false)
        }
    }
    
    func didFailLoading(model: Model) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView?.loadingView?.set(visible: false)
        }
    }
    
}
