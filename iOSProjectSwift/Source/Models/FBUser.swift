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
    
    var ID: String?
    var friends: Friends = Friends()
    var imageURL: URL?
    
}
