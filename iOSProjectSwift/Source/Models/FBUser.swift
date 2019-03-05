//
//  FBUserModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUser: User {
    
    //MARK: - Properties
    
    var imageModel: ImageModel? {
        return self.imageURL.flatMap { ImageModel.image(with: $0) }
    }
    
    var ID: String?
    var friends: Users = Users()
    var imageURL: URL?
    
}
