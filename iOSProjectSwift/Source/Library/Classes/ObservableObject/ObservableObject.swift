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
            self.notifyOfState()
        }
    }
    
    var observationControllers: NSHashTable<ObservationController> = NSHashTable.weakObjects()
    var notify: Bool = true
    
    // MARK: - Public Functions
    
    func controller(for observer: AnyObject) -> ObservationController {
        let controller = ObservationController(observableObject: self, observer: observer)
        self.observationControllers.add(controller)
        
        return controller
        
    }
    
    func notifyOfState() {
        synchronized(self) {
            self.observationControllers.allObjects.forEach {
                $0.notify(of: self.state)
            }
        }
    }
    
    func notifyWithObject(_ object: AnyObject?) {
        synchronized(self) {
            self.observationControllers.allObjects.forEach {
                $0.notify(of: self.state, object: object)
            }
        }
    }
}

extension ObservableObject {
    class ObservationController {
        typealias Observer = AnyObject
        typealias Action = (ObservableObject) -> ()

        //MARK: - Private properties

        private var observer : Observer
        private var observableObject : ObservableObject
        private var relation = [ModelState : Action]()

        //MARK: - Initialization

        init(observableObject: ObservableObject, observer: Observer) {
            self.observableObject = observableObject
            self.observer = observer
        }

        //MARK: - Public functions

        func notify(of state: ModelState, object: AnyObject? = nil) {
            if let block = self.relation[state] {
                block(self.observableObject)
            }
        }
        
        subscript(state: ModelState) -> Action? {
            get {
                return self.relation[state]
            }

            set {
                self.relation[state] = newValue
            }
        }
    }
}

//
//  ObservableObject.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.


//import UIKit
//
//class ObservableObject {
//
//    // MARK: - Properties
//
//    var state: ModelState = .didUnload {
//        didSet {
//            self.notify(of: self.state)
//        }
//    }
//
//    var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()
//    var notify: Bool = true
//
//    // MARK: - Public Functions
//
//    func add(observer: AnyObject) {
//        synchronized(self) {
//            self.observers.add(observer)
//        }
//    }
//
//    func remove(observer: AnyObject) {
//        synchronized(self) {
//            self.observers.remove(observer)
//        }
//    }
//
//    func isObserved(by object: AnyObject) -> Bool {
//        return synchronized(self, block: { () -> (Bool) in
//            return self.observers.contains(object)
//        })
//    }
//
//    func notify(of state: ModelState) {
//        synchronized(self) {
//            self.notifyWith(self.selector(for: state))
//        }
//    }
//
//    func notifyOfState(_ state: ModelState, with object: AnyObject) {
//        synchronized(self) {
//            self.notifyWith(self.selector(for: state), with: object)
//        }
//    }
//
//    func perform(notification: Bool, block: () -> ()) {
//        let notify = self.notify
//        self.notify = notification
//        block()
//        self.notify = notify
//    }
//
//    //Method created for overriding, do not call directly
//    func selector(for state: ModelState) -> Selector? {
//        return nil
//    }
//
//    // MARK: - Private Functions
//
//    private func notifyWith(_ selector: Selector?, with object: AnyObject? = nil) {
//        if self.notify {
//            self.observers.allObjects.forEach({ (object) in
//                if (object.responds(to: selector)) {
//                    _ = object.perform(selector, with: object)
//                }
//            })
//        }
//    }
//}
//
//
