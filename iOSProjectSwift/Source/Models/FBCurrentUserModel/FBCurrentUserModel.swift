//
//  FBCurrentUser.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import FacebookCore
import FacebookLogin
import FacebookShare

class FBCurrentUserModel: FBUserModel {
    
    //MARK: - Properties
    
    var token: String?
    var authorized: Bool {
        if let serverToken = AccessToken.current?.userId {
            return self.token == serverToken
        }
        
        return false
    }
}
