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
            self.notifyOfState(state: self.state)
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
    
    func isObservedBy(object: NSObject) -> Bool {
        return self.observers.contains(object)
    }
    
    func notifyOfState(state: ModelState) {
        self.notifyOfStateWith(selector: self.selector(forState: state))
    }
    
    func notifyOfState(state: ModelState,with object: NSObject) {
        self.notifyOfStateWith(selector: self.selector(forState: state), object: object)
    }
    
    func perform(notification: Bool, block: () -> ()) {
        let notify = self.notify
        self.notify = notification
        block()
        self.notify = notify
    }
    
    // MARK: - Private Methods
    
    private func selector(forState: ModelState) -> Selector? {
        return nil
    }
    
    private func notifyOfStateWith(selector: Selector?) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: self)
                }
            })
        }
    }
    
    private func notifyOfStateWith(selector: Selector?, object: NSObject) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: object)
                }
            })
        }
    }
}



