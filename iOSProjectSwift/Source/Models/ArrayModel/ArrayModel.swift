//
//  ArrayModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

class ArrayModel<Type>: Model {
    
    //MARK: - Properties
    
    var objects: Array<Type> = []
    var count: Int {
        return self.objects.count
    }
    
    //MARK: - Public Methods
    
    func add(object: Type) {
        self.insert(object: object, index: self.count)
    }
    
    func add(objects: Type) {
        for object in objects as! [Type] {
            self.add(object: object)
        }
    }
    
    func insert(object: Type, index: Int) {
        synchronized(self) {
            if self.count >= index {
                self.objects.insert(object, at: index)
                //add notification
            }
        }
    }
    
    func remove(object: Type) {
        self.removeObjectAt(index: self.index(of: object))
    }
    
    func remove(objects: Type) {
        for object in self.objects {
            self.remove(object: object)
        }
    }
    
    func removeObjectAt(index: Int) {
        synchronized(self) {
            if self.count > index {
                self.objects.remove(at: index)
                //add notification
            }
        }
    }
    
    func index(of object: Type) -> Int {
        return synchronized(self, block: {
            return self.objects.index(where: { (object) -> Bool in
                return true
            })!
        })
    }
    
}
