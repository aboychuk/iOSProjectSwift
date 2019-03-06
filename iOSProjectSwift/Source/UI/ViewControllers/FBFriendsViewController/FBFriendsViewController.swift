//
//  FBFriendsViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension FBFriendsViewController: UITableViewDelegate {
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = self.usersModel?[indexPath.row] as? FBUser else { return }

        let detailController = FBDetailViewController(model: user, currentUser: self.currentUser)
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

class FBFriendsViewController: FBViewController, RootView {
    
    //MARK: - Rootview Protocol

    typealias ViewType = FBFriendsView
    
    //MARK: - Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let loadingView = self.rootView?.loadingView
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
            }
        
            self.observationController?[.willLoad] = { [weak loadingView] _, _ in
                loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak self, weak loadingView] _, _ in
                loadingView?.set(visible: false)
                guard let model = self?.model else { return }
                self?.updateWithModel(model)
            }
            
            self.observationController?[.didChange] = { [weak self, weak loadingView] _, _ in
                loadingView?.set(visible: false)
                guard let model = self?.model else { return }
                self?.updateWithModel(model)
            }
        }
    }
    
    //MARK: - Private properties
    
    private var usersModel: Users? {
        return self.model as? Users
    }
    
    //MARK: - Initializations
    
    init(model: Users, currentUser: FBCurrentUser) {
        super.init(nibName: typeString(FBFriendsViewController.self), bundle: .main)
        
        self.currentUser = currentUser
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
        self.registerTableViewCell()
        self.context = FBFriendsContext(model: self.model)
    }
    
    //MARK: - Public functions
    
    func updateWithModel(_ model: Model) {
        self.rootView?.fillWithModel()
    }
        
    //MARK: - Private functions
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: typeString(FBUserCell.self), bundle: .main)
        self.rootView?.tableview?.register(nib, forCellReuseIdentifier: typeString(FBUserCell.self))
    }
    
    private func prepareNavigationTitle() {
        self.navigationItem.title = "Friends"
    }
}
