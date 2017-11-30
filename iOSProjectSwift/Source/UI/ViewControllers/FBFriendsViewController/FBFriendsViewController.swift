//
//  FBFriendsViewController.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/18/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBFriendsViewController: FBViewController
//UITableViewDelegate, UITableViewDataSource
{
    
    //MARK: - UITableViewDataSource protocol
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return self.model.count
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return 0
//    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareNavigationTitle()
        if let friendsModel = self.model {
            self.context = FBFriendsContext(model: friendsModel)
        }
    }
    
    //MARK: - Public functions
    
    override func updateWithModel(_ model: Model) {
//        self.rootView.fillWithModel
    }
    
    //MARK: - Private functions
    
    private func prepareNavigationTitle() {
        self.navigationItem.title = "Friends"
    }

    
}
