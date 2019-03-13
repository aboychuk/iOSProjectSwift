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
    typealias Model = Friends
    
    // MARK: - Properties
    
    var model: Friends
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
    
    init(friends: Friends) {
        self.model = friends
    }
    
    // MARK: - Private
    
    internal func parse(_ json: JSON) -> Friends {
        return FBParserService.updateFriends(self.model, from: json)
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let fields = "fields"
        static let fieldKeys = "first_name,last_name,picture.type(large)"
        static let plistName = "UserDetail.plist"
        static let emptyString = "empty"
    }
    
}
