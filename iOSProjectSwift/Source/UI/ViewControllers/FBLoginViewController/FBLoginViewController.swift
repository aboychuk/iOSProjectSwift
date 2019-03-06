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

class FBLoginViewController: UIViewController, RootView, ControllerType {
    typealias ViewModelType = FBLoginViewModel
    typealias ViewType = FBloginView
    
    // MARK: - Properties
    
    private var viewModel: FBLoginViewModel?
    private var disposeBag = DisposeBag()
    
    // MARK: - View lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.map { self.configure(with: $0) }
    }
    
    // MARK: - Private
    
    internal func configure(with viewModel: FBLoginViewModel) {
        self.rootView?.loginButton?.rx.tap
            .asObservable()
            .subscribe(viewModel.input.didTapOnLogin)
            .disposed(by: self.disposeBag)
        
        self.viewModel?.output.errorObservable
            .subscribe(
                onNext: { error in
                    self.presentAlertError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel?.output.authorizedObservable
            .subscribe(
                onNext: { user in
                    // present next VC
            })
            .disposed(by: self.disposeBag)
    }
    
    private func showUserDetailViewController(user: FBCurrentUser) {
        let detailController = FBDetailViewController(model: user, currentUser: user)
        let navigationController = UINavigationController(rootViewController: detailController)
        
        self.present(navigationController, animated: true)
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBLoginViewModel) -> UIViewController {
        let viewController = FBLoginViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
}
