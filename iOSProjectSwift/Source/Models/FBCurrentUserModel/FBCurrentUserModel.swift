//
//  FBCurrentUser.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//


class FBCurrentUserModel: FBUserModel {
    
    //MARK: - Properties
    
    var token: String?
    var authorized: Bool {
        let userToken = self.token
        let serverToken = ""//FBSDKCurrentAccessToken
        return userToken == serverToken
    }
}
