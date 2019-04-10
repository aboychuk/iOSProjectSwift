//
//  FBGetFriendsService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/12/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FacebookShare

class FBGetFriendsService: FBGetServiceProtocol {
    typealias Model = ArrayModel<User>
    
    // MARK: - Properties
    
    var model: ArrayModel<User>
    var graphPath: String {
        return AccessToken.current?.userId ?? Constants.emptyString
    }
    var parameters: [String : String] {
        return [Constants.fields : Constants.fieldKeys]
    }
    var plistName: String {
        return Constants.plistName
    }
    
    // MARK: - Init
    
    init(friends: ArrayModel<User>) {
        self.model = friends
    }
    
    // MARK: - Private
    
    internal func parse(_ json: JSON) -> ArrayModel<User> {
        return FBParserService.updateFriends(self.model, from: json)
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let fields = "fields"
        static let fieldKeys = "friends{first_name,last_name,picture}"
        static let plistName = "UserFriends.plist"
        static let emptyString = "empty"
    }
    
}
