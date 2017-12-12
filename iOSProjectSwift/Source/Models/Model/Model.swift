//
//  Model.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

protocol ModelObserver {
    func didUnload(model: Model)
    func willLoad(model: Model)
    func didLoad(model: Model)
    func didFailLoading(model: Model)
}

enum ModelState {
    case didUnload
    case willLoad
    case didLoad
    case didFailLoading
    case didChange
}

extension Model : Hashable {
    
    //MARK: - Hashable
    
    static func ==(lhs: Model, rhs: Model) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class Model: ObservableObject {
    
    //MARK: - Properties
    
    var hashValue: Int
    
    //MARK: - Initializations
    
    init(model: Model) {
        self.hashValue = model.hashValue
        super.init()
    }
    
    //MARK: - Public Functions
    
    func load() {
        synchronized(self) {
            let state = self.state
            if state == .willLoad || state == .didLoad {
                self.notifyOfState()
                return
            }
            self.state = .willLoad
        }
        
        self.processLoading()
    }
    
    //method created for overriding, do not call directly
    func performLoadingInBackground() {
        
    }
    
    //MARK: - Private Functions
    
    private func processLoading() {
        let backgroundQueue = DispatchQueue.global(qos: .background)
        backgroundQueue.async {
            self.performLoadingInBackground()
        }
    }
}
