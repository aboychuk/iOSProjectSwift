//
//  FBGetContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class FBGetContext: Context {
    
    private enum Constants {
        static let plistName = "default.plist"
        static let emptyString = "empty"
    }
    
    //MARK: - Properties
    
    var graphPath: String {
        return Constants.emptyString
    }
    
    var parameters: [String : String] {
        return [Constants.emptyString : Constants.emptyString]
    }
    
    var pathToCachedResult: String? {
        return nil
    }
    
    var plistName: String {
        return Constants.plistName
    }
    
    //MARK: - Overrided Functions
    
    override func execute() {
        let model = self.model
        var modelState = self.model.state
        
        synchronized(model) {
            if modelState == .didUnload || modelState == .willLoad {
                model.notifyOfState()
                if modelState == .didLoad {
                    return
                }
            }
            modelState = .willLoad
        }
        super.execute()
    }
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        var state = self.model.state
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        request.start() { [weak self] (response, result) in
            switch result {
            case .success(let response):
                guard let resultJSON = (response.dictionaryValue) else { return }
                    self?.saveResult(result: resultJSON)
                    self?.parseResult(result: resultJSON)
                    state = .didLoad
            case .failed(let error):
                print(error)
                self?.loadResult()
                state = .didLoad
            }
            handler(state)
        }
    }
    
    //MARK: - Public Functions
    
    //Function created for overriding
    func parseResult(result: JSON) {
        
    }
    
    func saveResult(result: JSON) {
        _ = self.pathToCachedResult.map { NSKeyedArchiver.archiveRootObject(result, toFile: $0) }
    }
    
    func loadResult() {
        _ = self.pathToCachedResult.map { NSKeyedUnarchiver.unarchiveObject(withFile: $0) }
    }
}
