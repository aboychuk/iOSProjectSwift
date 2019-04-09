//
//  Functions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/8/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

//MARK: - Global typealias

public typealias JSON = [String : Any]

//MARK: - Global functions

public func synchronized<Type>(_ lock: AnyObject, block: () -> (Type)) -> Type {
    defer {
        objc_sync_exit(lock)
    }
    objc_sync_enter(lock)
    
    return block()
}

public func typeString<T>(_ type: T.Type) -> String {
    return String(describing: type)
}
