//
//  Credentials.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 4/8/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin
import FacebookShare

struct Credentials {
    
    // MARK: - Properties
    
    var id: String?
    var token: String?
    var authorized: Bool {
        return AccessToken.current?.userId != nil
            ? self.token == AccessToken.current?.userId
            : false
    }
}

extension Credentials: Codable { }

extension Credentials: Equatable {
    
}
