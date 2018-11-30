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
    
    var user: FBCurrentUserModel {
        guard let user = self.model as? FBCurrentUserModel else {
            return FBCurrentUserModel()
        }
        return user
    }
    
    var observable: ObservableObject<FBCurrentUserModel>
    
    //MARK: - Init
    
    init(observable: ObservableObject<FBCurrentUserModel>) {
        self.observable = observable
    }
    
    //MARK: - Overrided Functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (State) -> ()) {
        var state = self.observable.state
        guard let user = self.user else {
            state = State.didFailLoading
            
            return
        }
        if !user.authorized {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.publicProfile, .userFriends]) { LoginResult in
                switch LoginResult {
                case .failed(let error):
                    state = State.didFailLoading
                case .cancelled:
                    state = State.didFailLoading
                case .success(_,_,let token):
                    self.observable.value = self.fillUser(with: token)
                    state = State.didLoad
                }
            }
        } else {
            state = State.didLoad
        }
        self.observable.state = state
    }
    
    func fillUser(with token: AccessToken) -> FBCurrentUserModel {
        let user = self.user
        user.token = token.authenticationToken
        user.ID = token.userId
        
        return user
    }
}
