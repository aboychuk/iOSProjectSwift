//
//  Optional+Extensions.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 15.12.2017.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit

extension Optional {
    
    //MARK: - Applicative
    
    func apply<T>(f: ((Wrapped) -> T)?) -> T? {
        return self.flatMap { unwrapped in f.map { $0(unwrapped) }}
    }
}


