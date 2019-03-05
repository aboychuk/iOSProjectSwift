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

class FBCurrentUser: FBUser {
    
    //MARK: - Properties
    
    var token: String?
    var authorized: Bool {
        return AccessToken.current?.userId != nil ? self.token == AccessToken.current?.userId : false
    }
}
