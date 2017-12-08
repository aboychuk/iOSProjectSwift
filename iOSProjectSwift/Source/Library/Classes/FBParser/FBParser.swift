//
//  FBParser.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBParser {
    
    //Typealias
    
    typealias JSON = [String : Any]
    
    // MARK: Constants
    
    private struct Constants {
        static let userID = "id"
        static let userName = "fisrt_name"
        static let userSurname = "last_name"
        static let userPhoto = "picture.data.url"
        static let userFriends = "friends.data"
    }
    
    //MARK: - Public functions
    
    static func update(model: FBUserModel, from result: JSON) -> FBUserModel {
        let userID = result[Constants.userID] as? String
        let userName = result[Constants.userName] as? String
        let userSurname = result[Constants.userSurname] as? String
        let userPhotoString = result[Constants.userPhoto] as? String
        let userURL = URL(string: userPhotoString!)
        let userFriends = result[Constants.userFriends] as? Array<JSON>
        
        userFriends?.forEach({
            var user = FBUserModel()
            user = self.update(model: user, from: $0)
            model.friends?.add(object: user)
        })
        
        model.userID = userID
        model.name = userName
        model.surname = userSurname
        model.imageURL = userURL
        

        
        return model
    }
}
