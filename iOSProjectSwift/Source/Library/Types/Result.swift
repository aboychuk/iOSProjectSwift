//
//  Result.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 15.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    
    //MARK: - Functor
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .success(unwrapped):
            return Result<U>.success(f(unwrapped))
        case .failure(let error):
            return Result<U>.failure(error)
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
