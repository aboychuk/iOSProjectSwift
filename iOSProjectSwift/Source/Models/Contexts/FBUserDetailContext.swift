//
//  FBUserDetailContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserDetailContext: FBGetContext {
    
    private struct Constants {
        static let fields = "fields"
        static let fieldKeys = "first_name,last_name,picture.type(large)"
        static let plistName = "UserDetail.plist"
        static let emptyString = "empty"
    }
    
    //MARK: - Properties
    
    override var graphPath: String {
        return self.user?.userID ?? Constants.emptyString
    }
    
    override var parameters: [String : String] {
        return [Constants.fields : Constants.fieldKeys]
    }
    
    override var pathToCachedResult: String? {
        return FileManager.documentsPathAppend(folder: self.plistName)
    }
    
    override var plistName: String {
        return Constants.plistName
    }
    
    //MARK: - Public Functions
    
    override func parseResult(result: JSON) {
        guard let user = self.user else { return }
        self.model = FBParser.update(user: user, from: result)
    }
    
}
