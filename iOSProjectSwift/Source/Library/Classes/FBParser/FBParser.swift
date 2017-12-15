//
//  FBParser.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBParser {
    
    // MARK: Constants
    
    private struct Constants {
        static let userID = "id"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let userPhoto = "picture.data.url"
        static let userFriends = "friends.data"
    }
    
    //MARK: - Public functions
    
    static func update(user: FBUserModel, from result: JSON) -> FBUserModel {
        let ID = result[Constants.userID] as? String
        let firstName = result[Constants.firstName] as? String
        let lastName = result[Constants.lastName] as? String
        let userPhotoString = result[Constants.userPhoto] as? URL
//        let userURL = URL(string: userPhotoString!)
        
        user.ID = ID
        user.firstName = firstName
        user.lastName = lastName
//        user.imageURL = userURL
    
        return user
    }
    
    static func updateFriends(user: FBUserModel, from result: JSON) -> FBUserModel {
        let userFriends = result[Constants.userFriends] as? Array<JSON>

        userFriends?.forEach {
            var user = FBUserModel()
            user = self.update(user: user, from: $0)
            user.friends?.add(object: user)
        }
        
        return user
    }
}
