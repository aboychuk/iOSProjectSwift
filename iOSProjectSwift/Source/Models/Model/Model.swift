//
//  Model.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

class Model: Observable {
    
    //MARK: - Properties
    
    var state: State
    
    //MARK: - Init
    
    init() {
        self.state = State.didUnload
    }
    
    //MARK: - Public Functions
    
    func load() {
        let observable = ObservableObject(value: self)
        synchronized(observable) {
            let state = observable.state
            if state == .willLoad || state == .didLoad {
                observable.notify(of: state)
                return
            }
            observable.state = .willLoad
        }
        
        self.processLoading()
    }
    
    //method created for overriding, do not call directly
    func performLoadingInBackground() {
        
    }
    
    //MARK: - Private Functions
    
    private func processLoading() {
        DispatchQueue.global(qos: .background).async {
            self.performLoadingInBackground()
        }
    }
}
