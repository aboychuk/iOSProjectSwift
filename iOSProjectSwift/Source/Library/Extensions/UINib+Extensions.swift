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
    
    static func nib<T>(from type: T.Type, bundle: Bundle = .main) -> UINib? {
        return UINib(nibName: String.toString(from: type), bundle: bundle)
    }
    
    static func object<T>(from type: T.Type, bundle: Bundle = .main, options: [AnyHashable : Any]? = nil) -> T? {
        if let nib = self.nib(from: type, bundle: bundle) {
            return nib.object(from: type, owner: bundle, options: options)
        }
        
        return nil
    }
    
    //MARK: - Instance Functions

    func object<T>(from type: T.Type, owner: Any?, options: [AnyHashable : Any]?) -> T? {
        let objects = instantiate(withOwner: owner, options: options)
        //NSarray extension
        return objects.first as? T
    }
}
