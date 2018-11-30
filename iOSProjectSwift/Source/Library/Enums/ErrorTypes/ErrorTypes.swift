//
//  ErrorTypes.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/29/18.
//  Copyright © 2018 Andrew Boychuk. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case emptyUser
    case cancelledByUser
}
