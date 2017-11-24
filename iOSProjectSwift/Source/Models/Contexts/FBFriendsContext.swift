//
//  FBFriendsContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

class FBFriendsContext: FBGetContext {
    
    private struct FriendsConstants {
        static let fields = "fields"
        static let fieldKeys = "friends{first_name,last_name,picture}"
        static let plistName = "UserFriends.plist"
    }
    
    //MARK: - Properties
    
    override var graphPath: String? {
        return AccessToken.current?.userId
    }
    
    override var parameters: [String : String]? {
        return [FriendsConstants.fields : FriendsConstants.fieldKeys]
    }
    
    override var pathToCachedResult: String? {
        guard let path = FileManager.documentsPath() else {
            return nil
        }
        var cachePath = path
        cachePath.append(self.plistName)
        
        return cachePath
    }
    
    override var plistName: String {
        return FriendsConstants.plistName
    }
    
    //MARK: - Public Functions
    
    override func parseResult(result: AnyObject) {

    }
}
