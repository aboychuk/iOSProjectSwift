//
//  FBGetContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class FBGetContext: Context {
    
    //MARK: - Properties
    
    var graphPath: String?
    var parameters: [AnyHashable : Any]?
    
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
    
    override func executeWithCompletionHandler(_ handler: (ModelState) -> ()) {
        let request = FBSDKGraphRequest.init(graphPath: self.graphPath, parameters: self.parameters)
        request?.start(completionHandler: { [weak self] (connection, user, error) in
            guard let userInfo = user as [String]
        })
    }
    
}
