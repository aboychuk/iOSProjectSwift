//
//  User.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class UserModel: Model {
    
    struct Constants {
        static let firstName = "firstName"
        static let lastName = "lastName"
    }
    
    //MARK: - Properties
    
    var firstName: String?
    var lastName: String?
    var fullname: String? {
        if let userName = self.firstName {
            return self.lastName == nil ? self.firstName : "\(userName)  \(self.lastName ?? "")"
        }
        
        return nil
    }
    
    // MARK: Initialization
    
    override init() {
        self.firstName = Constants.firstName
        self.lastName = Constants.lastName
    }
    
    // MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey:Constants.firstName)
        aCoder.encode(self.lastName, forKey:Constants.lastName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: Constants.firstName) as? String
        self.lastName = aDecoder.decodeObject(forKey: Constants.lastName) as? String
    }
}
