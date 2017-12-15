//
//  Result.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 15.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(value: T)
    case Failure
}

extension Result {
    
    func map<U>(f: (T) -> U) -> Result<U> {
        switch self {
        case let .Success(unwrapped):
            return Result<U>.Success(value: f(unwrapped))
        case .Failure:
            return Result<U>.Failure
        }
    }
}
