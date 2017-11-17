//
//  FBLoginContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class FBLoginContext: Context {
    
    //MARK: - Overrided Functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        var state = self.model.state
        let model = self.model as! FBCurrentUserModel
        if !model.authorized {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.publicProfile, .userFriends]) { LoginResult in
                switch LoginResult {
                case .failed(let error):
                    print (error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(_,_,let token):
                    model.token = token.authenticationToken
                    state = .willLoad
                    handler(state)
                }
            }
        }
    }
    
    
}
