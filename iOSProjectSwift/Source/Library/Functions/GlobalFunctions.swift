//
//  GlobalFunctions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/8/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

//MARK: - Global functions

func synchronized<Type>(_ lock: AnyObject, block: () -> (Type)) -> Type {
    objc_sync_enter(lock)
    defer {
        objc_sync_exit(lock)
    }
    
    return block()
}

func toString<T>(_ type: T.Type) -> String {
    return String(describing: type)
}

//MARK: - Global typealias

typealias JSON = [String : Any]
