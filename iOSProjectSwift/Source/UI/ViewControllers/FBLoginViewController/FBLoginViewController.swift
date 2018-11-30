//
//  FBLoginViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, RootView, DisposeBagProtocol {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBloginView
    
    // MARK: - Private properties
    
    internal var disposeBag = DisposeBag()
    private var model: FBCurrentUserModel
    private var context: Context? {
        willSet {
            self.context?.cancel()
            newValue?.execute()
        }
    }
    
    
    //MARK: - Initializations
    
    init(model: FBCurrentUserModel) {
        self.model = model
        let observable = ObservableObject(value: model)
        self.context = FBLoginContext(model: observable)
        self.prepareObservation()

        super.init(nibName: toString(FBLoginViewController.self), bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private Functions
    
    private func prepareObservation() {
    }
    
    private func showUserDetailViewController(user: FBCurrentUserModel) {
        let detailController = FBUserDetailController(model: user, currentUser: user)
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true)
    }
}
