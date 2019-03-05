//
//  FBLoginService.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/5/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift
import FacebookLogin
import FacebookCore

class FBLoginService {
    
    // MARK: - Properties
    
    private let user: FBCurrentUser
    private let loginManager: LoginManager
    private let readPermissions: [ReadPermission]
    
    // MARK: - Init
    
    init(user: FBCurrentUser) {
        self.user = user
        self.loginManager = LoginManager()
        self.readPermissions = [.publicProfile, .userFriends]
    }
    
    // MARK: - Public
    
    public func login() -> Observable<Result<FBCurrentUser>> {
        let service = self
        return Observable.create { observer in
            if !service.user.authorized {
                let manager = service.loginManager
                manager.logIn(readPermissions: service.readPermissions) { result in
                    switch result {
                    case .failed(let error): observer.onNext(Result.failure(error))
                    case .cancelled: observer.onNext(Result.failure(LoginError.cancelledByUser))
                    case .success(_,_, let token): observer.onNext(service.fillUser(with: token))
                    }
                }
            } else {
                observer.onNext(Result.failure(LoginError.alreadyLoggedIn))
            }
 
            return Disposables.create()
        }
    }
    
    // MARK: - Private

    private func fillUser(with token: AccessToken) -> Result<FBCurrentUser> {
        let user = self.user
        user.token = token.authenticationToken
        user.ID = token.userId
        
        return Result.success(user)
    }
    
    //MARK: - Error
    
    private enum LoginError: Error {
        case emptyUser
        case cancelledByUser
        case alreadyLoggedIn
    }
}
