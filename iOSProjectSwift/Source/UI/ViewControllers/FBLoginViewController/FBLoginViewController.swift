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
        
        viewModel.output.errorObservable
            .subscribe(
                onNext: { error in
                    self.presentAlertError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.authorizedObservable
            .subscribe(
                onNext: { user in
                    self.presentDetailViewController(user: user)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func presentDetailViewController(user: FBUser) {
        let service = FBGetUserDetailService(user: user)
        let viewModel = FBDetailViewModel(service: service)
        let controller = FBDetailViewController.create(with: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        
        self.present(navigationController, animated: true)
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBLoginViewModel) -> UIViewController {
        let viewController = FBLoginViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
}
