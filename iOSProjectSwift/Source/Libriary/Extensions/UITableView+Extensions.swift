//
//  UITableView+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UITableView {
    
    //MARK: - Class Functions
    
    func reusableCellFrom(Class: AnyClass) -> UITableViewCell {
        let stringFromClass = String(describing:Class.self)
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
        ModelChange.update(tableView: self, inSection: row, rowAnimation: rowAnimation)
    }
}
