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
    
    private struct Constants {
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
    
    var user: FBUserModel? {
        return self.model as? FBUserModel
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
        
        request.start() { [weak self] (httpResponse, result) in
            switch result {
                
            case .success(let response):
                self?.saveResult(result: response as AnyObject)
                self?.parseResult(result: response as AnyObject)
                state = .didLoad
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
                state = .didFailLoading
                if state == .didFailLoading {
                    self?.loadResult()
                    state = .didLoad
                }
            }
            handler(state)
        }
    }
    
    //MARK: - Public Functions
    
    //Function created for overriding
    func parseResult(result: AnyObject) {
        
    }
    
    func saveResult(result: AnyObject) {
        if let path = self.pathToCachedResult {
            NSKeyedArchiver.archiveRootObject(result, toFile: path)
        }
    }
    
    func loadResult() {
        if let path = self.pathToCachedResult {
            NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
    }
}
