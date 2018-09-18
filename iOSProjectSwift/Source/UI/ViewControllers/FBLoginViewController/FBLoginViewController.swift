//
//  FBLoginViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FBLoginViewController : UIViewController, RootView {
    
    //MARK: - RootView protocol
    
    typealias ViewType = FBloginView
    
    // MARK: - Private properties
    
    private var viewModel: FBLoginViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Initializations
    
    init(viewModel: FBLoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: toString(FBLoginViewController.self), bundle: .main)
        self.prepareObservation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func prepareObservation() {
        self.viewModel.rx
    }
    
    private func showUserDetailViewController(user: FBCurrentUserModel) {
        let detailController = FBUserDetailController(model: user, currentUser: user)
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true)
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.loginButton?
            .rx
            .tap
            .bind(to: viewModel.didTapLoginButton)
            .disposed(by: self.disposeBag)
    }
}
