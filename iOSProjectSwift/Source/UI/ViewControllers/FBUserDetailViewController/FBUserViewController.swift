//
//  FBUserDetailViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import RxSwift

class FBUserViewController: UIViewController, ControllerType, RootView {
    typealias ViewModelType = FBUserViewModel
    typealias ViewType = FBUserView
    typealias Friends = ArrayModel<User>
    
    //MARK: - Properties
    
    private var viewModel: FBUserViewModel?
    private var disposeBag = DisposeBag()
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.viewModel.map { self.configure(with: $0) }
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBUserViewModel) -> UIViewController {
        let viewController = FBUserViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Private
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = self.rootView?.logoutBarButton
    }
    
    internal func configure(with viewModel: FBUserViewModel) {
        
        self.rootView?.logoutBarButton?.rx.tap
            .asObservable()
            .subscribe(viewModel.input.didTapOnLogout)
            .disposed(by: self.disposeBag)
        
        self.rootView?.friendsButton?.rx.tap
            .asObservable()
            .subscribe(viewModel.input.didTapOnFriends)
            .disposed(by: self.disposeBag)
        
        viewModel.output.errorObservable
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] error in
                    self?.presentAlertError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.userObservable
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] user in
                    //TODO: Fix fillMethod remove model add raw data String Image
                    self?.rootView?.fillWithModel(user)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.friendsObservable
            .subscribe(
                onNext: { [weak self] friends in
                    self?.presentFriendsViewController(friends: friends)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.logoutObservable
            .subscribe(
                onNext: { [weak self] in
                    self?.popToRootViewController()
            })
            .disposed(by: self.disposeBag)
    }
    
    //MARK: - Private
    
    private func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func presentFriendsViewController(friends: Friends) {
        let service = FBGetFriendsService(friends: friends)
        let viewModel = FBFriendsViewModel(service: service)
        let controller = FBFriendsViewController.create(with: viewModel)
        
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
