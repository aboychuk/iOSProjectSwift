//
//  FBUserDetailViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import RxSwift

class FBDetailViewController: UIViewController, ControllerType, RootView {
    typealias ViewModelType = FBDetailViewModel
    typealias ViewType = FBDetailView
    
    
    //MARK: - Properties
    
    var viewModel: FBDetailViewModel?
    private var disposeBag = DisposeBag()
    
    //MARK: - IBActions
    
    @IBAction func onFriends(sender: UIButton) {
        self.showFriendsViewController()
    }
    
    @IBAction func onLogout(sender: UIButton) {
//        self.logoutContext = FBLogoutContext(model: self.currentUser)
    }
    
    //MARK: - View Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.prepareNavigationItem()
//        self.context = FBUserDetailContext(model: self.model)
    }
    
    // MARK: - Private
    
    internal func configure(with viewModel: FBDetailViewModel) {
        // TODO: add logout action and friends action
        self.rootView?.friendsButton?.rx.tap
            .asObservable()
            .subscribe(viewModel.input.didTapOnFriends)
            .disposed(by: self.disposeBag)
        
        viewModel.output.errorObservable
            .subscribe(
                onNext: { error in
            self.presentAlertError(error: error)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.userObservable
            .subscribe(
                onNext: { [weak self] user in
                    //TODO: Fix fillMethod remove model add raw data String Image
            self?.rootView?.fillWithModel(user)
            })
            .disposed(by: self.disposeBag)
        
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBDetailViewModel) -> UIViewController {
        let viewController = FBDetailViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    //MARK: - Public functions
    
    func updateWithModel(_ model: Model) {
//        self.userModel.map { self.rootView?.fillWithModel($0) }
    }
    
    //MARK: - Private functions
    
    private func prepareNavigationItem() {
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
//                                                                 style: .done,
//                                                                 target: self,
//                                                                 action: #selector(onLogout(sender:)))
    }
    
    private func showFriendsViewController() {
//        guard let userFriends = self.userModel?.friends else { return }
//        let friendsController = FBFriendsViewController(model: userFriends, currentUser: self.currentUser)
//
//        self.navigationController?.pushViewController(friendsController, animated: true)
    }
}
