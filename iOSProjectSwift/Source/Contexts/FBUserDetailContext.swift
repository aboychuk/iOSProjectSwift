//
//  FBUserDetailContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

class FBUserDetailContext: FBGetContext {
    
    //MARK: - Properties
    
    override var graphPath: String {
        return self.user?.ID ?? Strings.EmptyString
    }
    
    override var parameters: [String : String] {
        return [Strings.FBDetailParameters.Fields : Strings.FBDetailParameters.FieldKeys]
    }
    
    override var pathToCachedResult: String? {
        return FileManager.documentsPathAppend(folder: self.plistName)
    }
    
    override var plistName: String {
        return Strings.FBDetailParameters.UserDetailPlist
    }
    
    var user: FBUserModel? {
        return self.model.value as? FBUserModel
    }

    //MARK: - Public Functions
    
    override func parseResult(result: JSON) {
        self.user.map { self.model.value = FBParser.update(user: $0, from: result) }
    }
    
}
