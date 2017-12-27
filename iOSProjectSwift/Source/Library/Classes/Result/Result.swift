//
//  Result.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 15.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(value: T)
    case failure
}

extension Result {
    
    //MARK: - Functor
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .success(unwrapped):
            return Result<U>.success(value: f(unwrapped))
        case .failure:
            return Result<U>.failure
        }
    }
    
    func isSuccess() -> Bool {
        switch self {
        case .success(_):
            return true
        case .failure:
            return false
        }
    }
    
    func isFailure() -> Bool {
        return !self.isSuccess()
    }
    
}
