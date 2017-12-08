//
//  FBFriendsViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBFriendsViewController: FBViewController, UITableViewDelegate, UITableViewDataSource, RootView {
    
    //MARK: - Rootview Protocol

    typealias ViewType = FBFriendsView
    
    //MARK: - Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let loadingView = self.rootView?.loadingView
            
            self.observationController?[.didUnload] = { [weak self] _, _ in
                loadingView?.set(visible: false)
                self?.dismiss(animated: true, completion: nil)
            }
        
            self.observationController?[.willLoad] = { _, _ in
                loadingView?.set(visible: true)
            }
            
            self.observationController?[.didLoad] = { [weak self] _, _ in
                loadingView?.set(visible: false)
                guard let model = self?.model else { return }
                self?.updateWithModel(model)
            }
            
            self.observationController?[.didChange] = { [weak self] _, _ in
                loadingView?.set(visible: false)
                guard let model = self?.model else { return }
                self?.updateWithModel(model)
            }
        }
    }
    
    //MARK: - Private properties
    
    var usersModel: UsersModel? {
        return self.model as? UsersModel
    }
    
    //MARK: - UITableViewDataSource protocol
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.usersModel?.count else { return 0 }
        
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCellWith(type: FBUserCell.self, index: indexPath)
        cell.userModel = self.usersModel?[indexPath.row] as? FBUserModel
        
        return cell
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
            self.context = FBFriendsContext(model: self.model)
    }
    
    //MARK: - Public functions
    
    func updateWithModel(_ model: Model) {
        self.rootView?.fillWithModel()
    }
    
    //MARK: - Private functions
    
    private func prepareNavigationTitle() {
        self.navigationItem.title = "Friends"
    }
}
