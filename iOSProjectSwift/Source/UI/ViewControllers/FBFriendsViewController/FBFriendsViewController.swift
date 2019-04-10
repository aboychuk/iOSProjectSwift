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
    private var bag = DisposeBag()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
        self.registerTableViewCell()
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
            viewModel
                .output
                .friendsObservable
                .bind(to: tableView.rx.items(cellIdentifier: typeString(FBUserCell.self),
                                             cellType: FBUserCell.self)) { (index, user, cell) in cell.userModel = user }
                .disposed(by: self.bag)
//            tableView.rx.itemSelected
            // TODO: add action on selected item show detailVC
        }
    }
}
