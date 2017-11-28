//
//  ObservableObject.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.


import UIKit

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
        
        func notify(of state: ModelState) {
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

class ObservableObject {
    
    // MARK: - Properties
    
    var state: ModelState = .didUnload {
        didSet {
            self.notifyOfState(self.state)
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
    
    func notifyOfState(_ state : ModelState) {
        synchronized(self) {
            self.observationControllers.allObjects.forEach{
                $0.notify(of: state)
            }
        }
    }

}

