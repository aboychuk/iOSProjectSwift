//
//  FBLoginService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/5/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBLoginService {
    
    // MARK: - Properties
    
    let user: FBCurrentUser
    
    // MARK: - Init
    
    init(user: FBCurrentUser) {
        self.user = user
    }
    
    // MARK: - Public
    
    public func login() -> Observable<Result<FBCurrentUser>> {
        return Observable.create { observable in
            
            return Disposables.create()
        }
    }
}
