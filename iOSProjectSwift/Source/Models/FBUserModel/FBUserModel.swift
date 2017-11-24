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
        if self.imageURL != nil {
            return ImageModel.init(url: imageURL!)
        }
        
        return nil
    }
    
    var userID: String?
    var friends: String?
    var imageURL: URL?
    
}
