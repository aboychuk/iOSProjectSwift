//
//  ArrayModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

class ArrayModel: Model {
    
    //MARK: - Properties
    
    var objects: Array<AnyObject> = []
    var count: Int {
        return self.objects.count
    }
    
    //MARK: - Public Methods
    
    func add(object: AnyObject) {
        synchronized(self) { self.objects.append(object) }
    }
    
    func add(objects: AnyObject) {
        for object in objects as! [AnyObject] {
            self.add(object: object)
        }
    }
    
    func remove(object: AnyObject) {
        self.objects.remove(at: <#T##Int#>)
    }
    
}
