//
//  UITableView+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UITableView {
    
    //MARK: - Instance Functions
    
    func reusableCellWith<T>(type: T.Type, index: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: toString(type), for: index) as? T else {
            fatalError("no reusable cell registered")
        }
        
        return cell
    }
    
    func updateTableWith(block: () -> ()) {
        self.beginUpdates()
        block()
        self.endUpdates()
    }
    
    func apply(ModelChange: ArrayModelChange,
               in section: Int = 0,
               rowAnimation: UITableView.RowAnimation = .automatic) {
        ModelChange.update(tableView: self, section: section, rowAnimation: rowAnimation)
    }
}
