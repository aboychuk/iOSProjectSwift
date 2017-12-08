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
    
    //MARK: - Properties
    
    var user : FBCurrentUserModel? {
        return self.model as? FBCurrentUserModel
    }
    
    //MARK: - Overrided Functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        var state = self.model.state
        guard let user = self.user else {
            state = .didFailLoading
            
            return
        }
        if !user.authorized {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.publicProfile, .userFriends]) { LoginResult in
                switch LoginResult {
                case .failed(let error):
                    print (error)
                    state = .didFailLoading
                case .cancelled:
                    print("User cancelled login.")
                    state = .didUnload
                case .success(_,_,let token):
                    user.token = token.authenticationToken
                    state = .willLoad
                }
                handler(state)
            }
        } else {
            handler(state)
        }
    }
}
