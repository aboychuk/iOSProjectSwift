//
//  Result.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 15.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Failure(Error)
}

extension Result {
    
    //MARK: - Functor
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .Success(unwrapped):
            return Result<U>.Success(f(unwrapped))
        case .Failure(let error):
            return Result<U>.Failure(error)
        }
    }
    
    func isSuccess() -> Bool {
        switch self {
        case .Success(_):
            return true
        case .Failure:
            return false
        }
    }
    
    func isFailure() -> Bool {
        return !self.isSuccess()
    }
}
