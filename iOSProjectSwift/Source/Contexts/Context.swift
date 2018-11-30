//
//  Context.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class Context {
    
    //MARK: - Properties
    
    var model: Model
    
    //MARK: - Initializations
    
    init(model: Model) {
        self.model = model
    }
    
    //MARK: - Public Functions
    
    func execute() {
        executeWithCompletionHandler() { [weak self] (modelState: State) in
            self?.model.state = modelState
        }
    }
    
    //Function created for overrideing do not call directly
    func executeWithCompletionHandler(_ handler:  @escaping (State) -> ()) {
        
    }
    
    func cancel() {
        
    }
    
}
