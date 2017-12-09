//
//  FBUserModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserModel: UserModel {
    
    //MARK: - Properties
    
    var image: ImageModel? {
        return self.imageURL.map({ ImageModel(url: $0) })
    }
    
    var userID: String?
    var friends: UsersModel?
    var imageURL: URL?
    
}
