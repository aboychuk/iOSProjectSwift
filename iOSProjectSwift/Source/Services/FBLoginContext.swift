//
//  FBLoginContext.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 11/17/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare
import RxSwift

class FBLoginContext: Context {
    
    //MARK: - Properties
    
    var user: FBCurrentUser? {
        return self.model as? FBCurrentUser
    }
    private var subject: PublishSubject<Result<FBCurrentUser>>
    
    //MARK: - Init
    
    init(user: FBCurrentUser, subject: PublishSubject<Result<FBCurrentUser>>) {
        self.subject = subject
        
        super.init(model: user)
    }
    
    //MARK: - Overrided Functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        let subject = self.subject
        guard let user = self.user else {
            subject.onNext(Result.failure(LoginError.emptyUser))
            return
        }
        if !user.authorized {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.publicProfile, .userFriends]) { LoginResult in
                switch LoginResult {
                case .failed(let error):
                    subject.onNext(Result.failure(error))
                case .cancelled:
                    subject.onNext(Result.failure(LoginError.cancelledByUser))
                case .success(_,_,let token):
                    let loggedUser = self.fillUser(with: token)
                    subject.onNext(loggedUser)
                }
            }
        } else {
            subject.onNext(Result.success(user))
        }
    }
    
    func fillUser(with token: AccessToken) -> Result<FBCurrentUser> {
        guard let user = self.user else {
            return Result.failure(LoginError.emptyUser)
        }
        user.token = token.authenticationToken
        user.ID = token.userId
        
        return Result.success(user)
    }
    
    //MARK: - Error
    
    enum LoginError: Error {
        case emptyUser
        case cancelledByUser
    }
}
