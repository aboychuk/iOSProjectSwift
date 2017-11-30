//
//  FBFriendsView.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/30/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBFriendsView: BaseView {
    
    //MARK: - Properties
    
    @IBOutlet var tableview: UITableView?
    
    //MARK: - Public functions
    
    func fillWithModel() {
        self.tableview?.reloadData()
    }
    
}
