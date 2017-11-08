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

    // MARK: - Public Methods
    
    func addObserver(object: NSObject) {
        self.observers.add(object)
    }

    func removeObserver(object: NSObject) {
        self.observers.remove(object)
    }
    
    func isObserved(by object: NSObject) -> Bool {
        return self.observers.contains(object)
    }
    
    func notify(of state: ModelState) {
        self.notifyWith(self.selector(for: state))
    }
    
    func notify(of state: ModelState, with object: NSObject) {
        self.notifyWith(self.selector(for: state), with: object)
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
    
    // MARK: - Private Methods
    
    private func notifyWith(_ selector: Selector?) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: self)
                }
            })
        }
    }
    
    private func notifyWith(_ selector: Selector?, with object: NSObject) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: object)
                }
            })
        }
    }
}
