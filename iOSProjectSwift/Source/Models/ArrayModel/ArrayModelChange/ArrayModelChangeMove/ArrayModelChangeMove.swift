//
//  ArrayModelChangeMove.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/16/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class ArrayModelChangeMove: ArrayModelChange {
    
    //MARK: - Properties
    
    var sourceIndex: Int
    var destinationIndex: Int
    
    //MARK: - Initializations
    
    init(sourceIndex: Int, destinationIndex: Int) {
        self.sourceIndex = sourceIndex
        self.destinationIndex = destinationIndex
    }
    
    //MARK: - Overrided Functions
    
    override func update(tableView: UITableView, section: Int, rowAnimation: UITableViewRowAnimation) {
        let srcIndex = IndexPath.init(row: self.sourceIndex, section: section)
        let dstIndex = IndexPath.init(row: self.destinationIndex, section: section)
        tableView.updateTableWith {
            tableView.moveRow(at: srcIndex, to: dstIndex)
        }
    }
}
