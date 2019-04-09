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

struct FBAuthenticationService {
    
    // MARK: - Properties
    
    private let loginManager = LoginManager()
    private let readPermissions: [ReadPermission] = [.publicProfile, .userFriends]
    
    // MARK: - Public
    
    public func login(credentials: Credentials) -> Observable<Result<Credentials>> {
        let service = self
        return Observable.create { observer in
            if !credentials.authorized {
                let manager = service.loginManager
                manager.logIn(readPermissions: service.readPermissions) { result in
                    switch result {
                    case .failed(let error): observer.onNext(Result.failure(error))
                    case .cancelled: observer.onNext(Result.failure(LoginError.cancelledByUser))
                    case .success(_,_, let token): observer.onNext(Result.success(self.fill(with: token)))
                    }
                }
            } else {
                observer.onNext(Result.failure(LoginError.alreadyLoggedIn))
            }
 
            return Disposables.create()
        }.observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
    }
    
    public func logout(credentials: Credentials) -> Observable<Bool> {
        return Observable.create { observable in
            if !credentials.authorized {
                observable.onNext(false)
            } else {
                self.loginManager.logOut()
                observable.onNext(true)
            }
            
            return Disposables.create()
        }.observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
    }
    
    // MARK: - Private

    private func fill(with token: AccessToken) -> Credentials {
        return Credentials(id: token.userId, token: token.authenticationToken)
    }
    
    //MARK: - Error
    
    private enum LoginError: Error {
        case cancelledByUser
        case alreadyLoggedIn
    }
}
