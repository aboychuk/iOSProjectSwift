//
//  WeakHashable.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension WeakHashable: Hashable {
    
    //MARK: - Hashable
    
    static func ==(lhs: WeakHashable<Object>, rhs: WeakHashable<Object>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

struct WeakHashable<Object: AnyObject & Hashable> {
    
    //MARK: - Public properties
    
    var hashValue: Int
    
    weak var object: Object?
    
    //MARK: - Initializations
    
    init(object: Object) {
        self.object = object
        self.hashValue = object.hashValue
    }
}
