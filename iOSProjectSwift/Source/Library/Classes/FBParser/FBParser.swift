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
        static let userName = "fisrt_name"
        static let userSurname = "last_name"
        static let userPhoto = "picture.data.url"
        static let userFriends = "friends.data"
    }
    
    //MARK: - Public functions
    
    static func update(user: FBUserModel, from result: JSON) -> FBUserModel {
        let userID = result[Constants.userID] as? String
        let userName = result[Constants.userName] as? String
        let userSurname = result[Constants.userSurname] as? String
        let userPhotoString = result[Constants.userPhoto] as? String
        let userURL = URL(string: userPhotoString!)
        
        user.userID = userID
        user.name = userName
        user.surname = userSurname
        user.imageURL = userURL
    
        return user
    }
    
    static func updateFriends(user: FBUserModel, from result: JSON) -> FBUserModel {
        let userFriends = result[Constants.userFriends] as? Array<JSON>

        userFriends?.forEach({
            var user = FBUserModel()
            user = self.update(user: user, from: $0)
            user.friends?.add(object: user)
        })
        
        return user
    }
}
