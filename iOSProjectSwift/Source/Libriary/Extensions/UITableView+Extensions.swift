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
    
    func reusableCellWith(cls: AnyClass) -> UITableViewCell {
        let stringFromClass = String(describing:cls)
        guard let cell = self.dequeueReusableCell(withIdentifier: stringFromClass) else {
            fatalError("\(stringFromClass)) cell could not be instantiated because it was not found on the tableView")
        }
        
        return cell
    }
    
    func updateTableWith(block: () -> ()) {
        self.beginUpdates()
        block()
        self.endUpdates()
    }
    
    func apply(ModelChange: ArrayModelChange,
               in row: Int = 0,
               rowAnimation: UITableViewRowAnimation = .automatic) {
        ModelChange.update(tableView: self, section: row, rowAnimation: rowAnimation)
    }
}
