//
//  User.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class User: Model {
    
    //MARK: - Properties
    
    var name: String?
    var surname: String?
    var fullname: String? {
        get {
            var fullname: String
            if let name = self.name {
                fullname += name
            }
            if let surname = self.surname {
                fullname += " " + surname
            }
            
            return fullname
        }
    }

}
