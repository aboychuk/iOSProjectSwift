//
//  ObservableObject.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.

//
//import UIKit
//
//class ObservableObject {
//    
//    // MARK: - Public properties
//    
//    var state: ModelState = .isCreated {
//        didSet {
//            self.notifyOfState()
//        }
//    }
//    
//    var observationControllers = Array<WeakHashable<ObservationController>>()
//    var notify: Bool = true
//    
//    // MARK: - Public functions
//    
//    func controller(for observer: AnyObject) -> ObservationController {
//        let controller = ObservationController(observableObject: self, observer: observer)
//        self.observationControllers.append(WeakHashable(object: controller))
//        
//        return controller
//    }
//    
//    func remove(controller: ObservationController) {
//        var array = self.observationControllers
//        if let index = array.index(of: WeakHashable(object: controller)) {
//            array.remove(at: index)
//            self.observationControllers = array
//        }
//    }
//    
//    func notifyOfState() {
//        synchronized(self) {
//            for controller in self.observationControllers {
//                controller.object?.notify(of: self.state)
//            }
//        }
//    }
//    
//    func notifyWithObject(_ object: AnyObject?) {
//        synchronized(self) {
//            for controller in self.observationControllers {
//                controller.object?.notify(of: self.state, object: object)
//            }
//        }
//    }
//    
//    func perform(notification: Bool, block: () -> ()) {
//        synchronized(self) {
//            let notify = self.notify
//            self.notify = notification
//            block()
//            self.notify = notify
//        }
//    }
//}
//
//extension ObservableObject {
//    class ObservationController: Hashable {
//        
//        typealias ObserverType = AnyObject
//        typealias ActionType = (ObservableObject, AnyObject?) -> ()
//        
//        //MARK: - Public properties
//
//        var hashValue: Int
//
//        //MARK: - Private properties
//
//        private var observer : ObserverType
//        private var observableObject : ObservableObject
//        private var relation = [ModelState : ActionType]()
//
//        //MARK: - Initialization
//
//        init(observableObject: ObservableObject, observer: ObserverType) {
//            self.observableObject = observableObject
//            self.observer = observer
//            self.hashValue = observer.hashValue
//        }
//
//        //MARK: - Public functions
//
//        func notify(of state: ModelState, object: AnyObject? = nil) {
//            self.relation[state].map { $0(self.observableObject, object) }
//        }
//        
//        //MARK: - Subscript
//        
//        subscript(state: ModelState) -> ActionType? {
//            get { return self.relation[state] }
//            set { self.relation[state] = newValue }
//        }
//        
//        //MARK: - Hashable
//        
//        static func ==(lhs: ObservableObject.ObservationController,
//                       rhs: ObservableObject.ObservationController) -> Bool {
//            return lhs.hashValue == rhs.hashValue
//        }
//    }
//}
