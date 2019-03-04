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
    
    private enum Constants {
        static let fields = "fields"
        static let fieldKeys = "friends{first_name,last_name,picture}"
        static let plistName = "UserFriends.plist"
        static let emptyString = "empty"
    }
    
    //MARK: - Properties
    
    override var graphPath: String {
        return AccessToken.current?.userId ?? Constants.emptyString
    }
    
    override var parameters: [String : String] {
        return [Constants.fields : Constants.fieldKeys]
    }
    
    override var pathToCachedResult: String? {
        return FileManager.documentsPathAppend(folder: self.plistName)
    }
    
    override var plistName: String {
        return Constants.plistName
    }
    
    var users: UsersModel? {
        return self.model as? UsersModel
    }
    
    //MARK: - Public Functions
    
    override func parseResult(result: JSON) {
        self.users.map { self.model = FBParser.updateFriends(users: $0, from: result) }
    }
}
