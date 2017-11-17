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
    
    //MARK: - Properties
    
    var graphPath: String?
    var parameters: [String : Any]?
    var pathToCachedResult: String?
    var plistName: String?
    
    //MARK: - Overrided Functions
    
    override func execute() {
        let model = self.model
        var modelState = self.model.state
        
        synchronized(model) {
            if modelState == .didUnload || modelState == .willLoad {
                model.notify(of: modelState)
                if modelState == .didLoad {
                    return
                }
            }
            modelState = .willLoad
        }
        super.execute()
    }
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        let connection = GraphRequestConnection()
        if let graphPath = self.graphPath {
            if let parameters = self.parameters {
                connection.add(GraphRequest(graphPath: graphPath, parameters: parameters)) { httpResponse, result in
                    var state = self.model.state
                    switch result {
                    case .success(let response):
                        self.saveResult(result: response as AnyObject)
                        self.parseResult(result: response as AnyObject)
                        state = .didLoad
                    case .failed(let error):
                        print("Graph Request Failed: \(error)")
                        state = .didFailLoading
                        if state == .didFailLoading {
                            self.loadResult()
                            state = .didLoad
                        }
                    }
                    handler(state)
                }
            }
        }
        connection.start()
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
