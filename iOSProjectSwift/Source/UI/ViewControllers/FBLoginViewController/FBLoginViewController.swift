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
    
    private weak var viewModel: FBLoginViewModel?
    private var disposeBag = DisposeBag()
    
    // MARK: - View lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.map { self.configure(with: $0) }
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBLoginViewModel) -> UIViewController {
        let viewController = FBLoginViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Private
    
    internal func configure(with viewModel: FBLoginViewModel) {
        self.rootView?
            .loginButton?.rx.tap
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(viewModel.input.didTapOnLogin)
            .disposed(by: self.disposeBag)
        
        viewModel
            .output
            .errorObservable
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] error in
                    self?.presentAlertError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        viewModel
            .output
            .authorizedObservable
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] in
                    self?.presentDetailViewController(credentials: $0)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func presentDetailViewController(credentials: Credentials) {
        let user = User(credentials: credentials)
        let service = FBGetUserService(user: user)
        let viewModel = FBUserViewModel(service: service)
        let controller = FBUserViewController.create(with: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        
        self.present(navigationController, animated: true)
    }
}
