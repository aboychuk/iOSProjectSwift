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
    
    var imageModel: ImageModel? {
        return self.imageURL.flatMap { ImageModel.image(with: $0) }
    }
    
    var ID: String?
    var friends: UsersModel = UsersModel()
    var imageURL: URL?
    
}
