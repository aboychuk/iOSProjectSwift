//
//  ObservableObject.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.


import UIKit

class ObservableObject {
    
    // MARK: - Properties
    
    var state: ModelState = .didUnload {
        didSet {
            self.notify(of: self.state)
        }
    }
    
    var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    var notify: Bool = true

    // MARK: - Public Functions
    
    func add(observer: NSObject) {
        synchronized(self) {
            self.observers.add(observer)
        }
    }

    func remove(observer: NSObject) {
        synchronized(self) {
            self.observers.remove(observer)
        }
    }
    
    func isObserved(by object: NSObject) -> Bool {
        return synchronized(self, block: { () -> (Bool) in
            return self.observers.contains(object)
        })
    }
    
    func notify(of state: ModelState) {
        synchronized(self) {
            self.notifyWith(self.selector(for: state))
        }
    }
    
    func notify(of state: ModelState, with object: NSObject) {
        synchronized(self) {
            self.notifyWith(self.selector(for: state), with: object)
        }
    }
    
    func perform(notification: Bool, block: () -> ()) {
        let notify = self.notify
        self.notify = notification
        block()
        self.notify = notify
    }
    
    //Method created for overriding, do not call directly
    func selector(for state: ModelState) -> Selector? {
        return nil
    }
    
    // MARK: - Private Functions
    
    private func notifyWith(_ selector: Selector?, with object: NSObject? = nil) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: object)
                }
            })
        }
    }
}
