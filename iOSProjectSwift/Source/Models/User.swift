//
//  User.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/10/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

protocol UserType {
    var id: String? { get set }
    var firstName: String? { get set }
    var lastName: String? { get set }
    var fullName: String { get }
    var imageUrl: String? { get set }
}

extension UserType {
    var fullName: String {
        return [self.firstName, self.lastName]
            .compactMap { $0 }
            .joined(separator: " ")
    }
}

struct User: UserType {
    
    //MARK: - Properties
    
    var id: String?
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    var credentials: Credentials?
    
    // MARK: - Init
    
    init() { }
    
    init(credentials: Credentials) {
        self.credentials = credentials
    }


    // MARK: - Private constants
    
    private enum Constants {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let hashValue = "hashValue"
    }
}

extension User: Codable { }

extension User: Equatable { }

