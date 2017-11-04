//
//  ObservableObject.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.


import UIKit

class ObservableObject: NSObject {
    // MARK:Properties
    var state: ModelState = ModelState.modelDidUnload
    var observers: NSHashTable<AnyObject>?

    // MARK:Methods
    func addObserver(observer: NSObject) -> () {
        self.observers?.add(observer)
    }

    func removeObserver(observer: NSObject) -> () {
        self.observers?.remove(observer)
    }
    
    func isObservedBy(observer: NSObject) -> (Bool) {
        return (self.observers?.contains(observer))!
    }
    
    func notifyOfStateWith(selector: Selector?, observer: NSObject) {
    self.observers?.allObjects.forEach({ (object) in
            if (object.responds(to: selector)) {
                _ = object.perform(selector, with: observer)
            }
        })
    }
}



