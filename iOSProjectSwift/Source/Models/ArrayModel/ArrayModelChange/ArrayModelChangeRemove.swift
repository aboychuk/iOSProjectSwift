//
//  ArrayModelChangeRemove.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/16/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ArrayModelChangeRemove: ArrayModelChange {
    
    //MARK: - Properties
    
    var index: Int
    
    //MARK: - Initializations
    
    init(index: Int) {
        self.index = index
    }
    
    //MARK: - Overrided Functions
    
    override func update(tableView: UITableView, section: Int, rowAnimation: UITableView.RowAnimation) {
        let index = IndexPath(row: self.index, section: section)
        tableView.updateTableWith {
            tableView.deleteRows(at: [index], with: rowAnimation)
        }
    }
}
