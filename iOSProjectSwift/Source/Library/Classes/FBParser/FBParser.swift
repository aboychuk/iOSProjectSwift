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
        static let userPicture = "picture"
        static let userData = "data"
        static let userUrl = "url"
        static let userFriends = "friends"
    }
    
    //MARK: - Public functions
    
    static func update(user: FBUserModel, from result: JSON) -> FBUserModel {
        let ID = result[Constants.userID] as? String
        let firstName = result[Constants.firstName] as? String
        let lastName = result[Constants.lastName] as? String
        let pictures = result[Constants.userPicture] as? JSON
        let data = pictures?[Constants.userData] as? JSON
        let userPhotoString = data?[Constants.userUrl] as? String
        let userURL = userPhotoString.flatMap { URL(string: $0) }
        
        user.ID = ID
        user.firstName = firstName
        user.lastName = lastName
        user.imageURL = userURL
    
        return user
    }
    
    static func updateFriends(users: UsersModel, from result: JSON) -> UsersModel {
        let friends = result[Constants.userFriends] as? JSON
        let friendsData = friends?[Constants.userData]

//        userFriends?.forEach {
//            var user = FBUserModel()
////            user = self.update(user: user, from: $0)
//            users.add(object: user)
////            user.friends?.add(object: user)
//        }
        
        return users
    }
}
