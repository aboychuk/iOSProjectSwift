//
//  FBFriendsViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBFriendsViewController: UIViewController, ControllerType, RootView {
    typealias ViewModelType = FBFriendsViewModel
    typealias ViewType = FBFriendsView
    
    
    // MARK: - Properties
    
    var viewModel: FBFriendsViewModel?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
        self.registerTableViewCell()
    }
    
    // MARK: - Static
    
    static func create(with viewModel: FBFriendsViewModel) -> UIViewController {
        
    }
    
    // MARK: - Public
    
    func updateWithModel(_ model: Model) {
        self.rootView?.fillWithModel()
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
        
    }
}

extension FBFriendsViewController: UITableViewDelegate {
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = self.usersModel?[indexPath.row] as? FBUser else { return }
        
        let detailController = FBUserViewController(model: user, currentUser: self.currentUser)
        detailController.model = user
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension FBFriendsViewController: UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersModel.map { $0.count } ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCellWith(type: FBUserCell.self, index: indexPath)
        cell.userModel = self.usersModel?[indexPath.row] as? FBUser
        
        return cell
    }
}
