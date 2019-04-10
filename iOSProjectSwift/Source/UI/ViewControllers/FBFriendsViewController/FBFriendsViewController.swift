//
//  FBFriendsViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class FBFriendsViewController: UIViewController, ControllerType, RootView {
    typealias ViewModelType = FBFriendsViewModel
    typealias ViewType = FBFriendsView
    
    // MARK: - Properties
    
    private var viewModel: FBFriendsViewModel?
    private var disposeBag = DisposeBag()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
        self.registerTableViewCell()
        self.viewModel.map { self.configure(with: $0) }
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBFriendsViewModel) -> UIViewController {
        let viewController = FBFriendsViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
        
    // MARK: - Private
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: typeString(FBUserCell.self), bundle: .main)
        self.rootView?.tableview?.register(nib, forCellReuseIdentifier: typeString(FBUserCell.self))
    }
    
    private func prepareNavigationTitle() {
        self.navigationItem.title = "Friends"
    }
    
    internal func configure(with viewModel: FBFriendsViewModel) {
        if let tableView = self.rootView?.tableview {
            tableView.rx.itemSelected
                .asObservable()
                .subscribe(viewModel.input.didSelectModelAtindex)
                .disposed(by: self.disposeBag)
            
            viewModel
                .output
                .friendsObservable
                .bind(to: tableView.rx.items(cellIdentifier: typeString(FBUserCell.self),
                                             cellType: FBUserCell.self)) { (index, user, cell) in cell.userModel = user }
                .disposed(by: self.disposeBag)
            
            viewModel.output.friendObservable
                .subscribe(
                    onNext: { [weak self] user in
                        self?.presentUserViewController(user: user)
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    private func presentUserViewController(user: User) {
        let service = FBGetUserService(user: user)
        let viewModel = FBUserViewModel(service: service)
        let controller = FBUserViewController.create(with: viewModel)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
