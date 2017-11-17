//
//  User.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class UserModel: Model {
    
    struct Keys {
        static let name = "UserName"
        static let surname = "UserSurname"
    }
    
    //MARK: - Properties
    
    var name: String?
    var surname: String?
    var fullname: String? {
        if let name = self.name {
            return self.surname == nil ? name : "\(name)  \(self.surname ?? "")"
        }
        
        return nil
    }
    
    // MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey:Keys.name)
        aCoder.encode(self.surname, forKey:Keys.surname)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Keys.name) as? String
        self.surname = aDecoder.decodeObject(forKey: Keys.surname) as? String
    }
}
