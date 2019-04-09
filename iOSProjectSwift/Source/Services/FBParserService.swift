//
//  FBParser.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

struct FBParserService {
    typealias Friends = ArrayModel<User>
    
    // MARK: - Static
    
    static func update(user: User, from result: JSON) -> User {
        var filledUser = user
        let id = result[Constants.userID] as? String
        let firstName = result[Constants.firstName] as? String
        let lastName = result[Constants.lastName] as? String
        let pictures = result[Constants.userPicture] as? JSON
        let data = pictures?[Constants.userData] as? JSON
        let userPhotoUrl = data?[Constants.userUrl] as? String
        
        filledUser.id = id
        filledUser.firstName = firstName
        filledUser.lastName = lastName
        filledUser.imageUrl = userPhotoUrl
    
        return filledUser
    }
    
    static func updateFriends(_ users: Friends, from result: JSON) -> Friends {
        let friends = result[Constants.userFriends] as? JSON
        let friendsData = friends?[Constants.userData] as? [JSON]
        friendsData?.forEach {
            var user = User()
            user = self.update(user: user, from: $0)
            users.add(element: user)
        }
        
        return users
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let userID = "id"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let userPicture = "picture"
        static let userData = "data"
        static let userUrl = "url"
        static let userFriends = "friends"
    }
}
