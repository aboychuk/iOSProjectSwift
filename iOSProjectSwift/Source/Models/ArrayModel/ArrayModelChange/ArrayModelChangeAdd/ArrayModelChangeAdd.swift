//
//  ArrayModelChangeAdd.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/16/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ArrayModelChangeAdd: ArrayModelChange {
    
    //MARK: - Properties
    
    var index: Int
    
    //MARK: - Initializations
    
    init(index: Int) {
        self.index = index
    }
    
    //MARK: - Overrided Functions
    
    override func update(tableView: UITableView, section: Int, rowAnimation: UITableViewRowAnimation) {
        let index = IndexPath.init(row: self.index, section: section)
        tableView.updateTableWith {
            tableView.insertRows(at: [index], with: rowAnimation)
        }
    }
}
