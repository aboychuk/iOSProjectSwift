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
        return UINib(nibName: toString(from: type), bundle: bundle)
    }
    
    static func object<T>(from type: T.Type, bundle: Bundle = .main, options: [AnyHashable : Any]? = nil) -> T? {
        return self.nib(from: type, bundle: bundle).map {
            $0.object(from: type, owner: bundle, options: options)
            } as? T
    }
    
    //MARK: - Instance Functions

    func object<T>(from type: T.Type, owner: Any?, options: [AnyHashable : Any]?) -> T? {
        let objects = instantiate(withOwner: owner, options: options).filter { $0 is T }

        return objects.first as? T
    }
}
