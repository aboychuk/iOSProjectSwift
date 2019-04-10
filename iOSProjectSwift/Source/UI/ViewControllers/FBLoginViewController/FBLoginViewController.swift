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

class FBLoginViewController: UIViewController, ControllerType {
    typealias ViewModelType = FBLoginViewModel
    
    // MARK: - Properties
    
    private var viewModel: FBLoginViewModel?
    private var disposeBag = DisposeBag()
    @IBOutlet var loginButton: UIButton?
    
    // MARK: - View lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.map { self.configure(with: $0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBLoginViewModel) -> UIViewController {
        let viewController = FBLoginViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Private
    
    internal func configure(with viewModel: FBLoginViewModel) {
        self.loginButton?.rx.tap
            .asObservable()
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
                    self?.presentUserViewController(credentials: $0)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func presentUserViewController(credentials: Credentials) {
        let user = User(credentials: credentials)
        let service = FBGetUserService(user: user)
        let viewModel = FBUserViewModel(service: service)
        let controller = FBUserViewController.create(with: viewModel)
        
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
