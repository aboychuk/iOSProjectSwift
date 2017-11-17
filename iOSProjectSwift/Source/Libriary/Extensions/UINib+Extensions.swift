//
//  UINib+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension UINib {
 
    //MARK: - Class Functions
    
    static func nib(with cls: AnyClass, bundle:Bundle = .main) -> UINib {
        return UINib(nibName: String(describing:cls), bundle: bundle)
    }
    
    //MARK: - Instance Functions

    func object(with cls: AnyClass, owner: Any?, options: [AnyHashable : Any]?) -> Any? {
        let objects = instantiate(withOwner: owner, options: options)
        
        return objects.filter
    }
    
}
