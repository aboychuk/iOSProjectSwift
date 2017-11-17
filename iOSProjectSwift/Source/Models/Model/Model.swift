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
    case didChanged
}

class Model: ObservableObject {
    
    //MARK: - Public Functions
    
    func load() {
        synchronized(self) {
            let state = self.state
            if state == .willLoad || state == .didLoad {
                self.notify(of: state)
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
    
    //MARK: - Overrided Functions
    
    override func selector(for state: ModelState) -> Selector? {
        switch state {
        case .didUnload:
            return Selector(("didUnload:"))
        case .willLoad:
            return Selector(("willLoad:"))
        case .didLoad:
            return Selector(("didLoad:"))
        case .didFailLoading:
            return Selector(("didFailLoading:"))
        default:
            return super.selector(for: state)
        }
    }
}
