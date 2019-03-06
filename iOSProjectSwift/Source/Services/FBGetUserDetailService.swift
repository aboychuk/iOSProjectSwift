//
//  FBGetUserDetailService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/6/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation

class FBGetUserDetailService: FBGetServiceProtocol {
    typealias Model = FBUser
    
    // MARK: - Properties
    
    var model: FBUser
    var graphPath: String {
        return self.model.ID ?? Constants.emptyString
    }
    var parameters: [String : String] {
        return [Constants.fields : Constants.fieldKeys]
    }
    var plistName: String {
        return Constants.plistName
    }
    var pathToCachedResult: String? {
        return FileManager.documentsPathAppend(folder: self.plistName)
    }
    
    // MARK: - Init
    
    init(user: FBUser) {
        self.model = user
    }
    
    // MARK: - Private
    
    internal func parse(_ json: JSON) -> FBUser {
        return FBParserService.update(user: self.model, from: json)
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let fields = "fields"
        static let fieldKeys = "first_name,last_name,picture.type(large)"
        static let plistName = "UserDetail.plist"
        static let emptyString = "empty"
    }
    
}
