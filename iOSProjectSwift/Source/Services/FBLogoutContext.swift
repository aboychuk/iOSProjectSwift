//
//  FBLogoutContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class FBLogoutContext: Context {
    
    //MARK: - Properties
    
    var user: FBCurrentUser? {
        return self.model as? FBCurrentUser
    }
    
    //MARK: - Overrided functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        LoginManager().logOut()
        self.user?.token = nil
        handler(.didUnload)
    }
    
}
