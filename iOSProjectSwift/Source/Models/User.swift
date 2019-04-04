//
//  User.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class User: Hashable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.fullname == rhs.fullname
    }
    
    
    private enum Constants {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let hashValue = "hashValue"
    }
    
    //MARK: - Properties
    
//    var user: UserModel

    var firstName: String?
    var lastName: String?
    var fullname: String? {
        let user = self
        
        return [user.firstName, user.lastName].compactMap { $0 }.joined(separator: " ")
    }
    var hashValue: Int
    
    // MARK: Initialization
    
    init() {
        self.firstName = Constants.firstName
        self.lastName = Constants.lastName
        self.hashValue = self.lastName.hashValue
    }
    
    // MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey:Constants.firstName)
        aCoder.encode(self.lastName, forKey:Constants.lastName)
        aCoder.encode(self.hashValue, forKey:Constants.hashValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: Constants.firstName) as? String
        self.lastName = aDecoder.decodeObject(forKey: Constants.lastName) as? String
        self.hashValue = aDecoder.decodeInteger(forKey: Constants.hashValue)
    }
}
