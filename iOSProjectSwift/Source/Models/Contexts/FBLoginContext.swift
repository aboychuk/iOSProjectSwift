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
    
    var user: FBCurrentUserModel? {
        return self.model as? FBCurrentUserModel
    }
    private var subject: PublishSubject<Result<FBCurrentUserModel>>
    
    //MARK: - Init
    
    init(user: FBCurrentUserModel, subject: PublishSubject<Result<FBCurrentUserModel>>) {
        self.subject = subject
        
        super.init(model: user)
    }
    
    //MARK: - Overrided Functions
    
    override func executeWithCompletionHandler(_ handler: @escaping (ModelState) -> ()) {
        let subject = self.subject
        guard let user = self.user else {
            subject.onNext(Result.Failure(LoginError.emptyUser))
            return
        }
        if !user.authorized {
            let manager = LoginManager()
            manager.logIn(readPermissions: [.publicProfile, .userFriends]) { LoginResult in
                switch LoginResult {
                case .failed(let error):
                    subject.onNext(Result.Failure(error))
                case .cancelled:
                    subject.onNext(Result.Failure(LoginError.cancelledByUser))
                case .success(_,_,let token):
                    let loggedUser = self.fillUser(with: token)
                    subject.onNext(loggedUser)
                }
            }
        } else {
            subject.onNext(Result.Success(user))
        }
    }
    
    func fillUser(with token: AccessToken) -> Result<FBCurrentUserModel> {
        guard let user = self.user else {
            return Result.Failure(LoginError.emptyUser)
        }
        user.token = token.authenticationToken
        user.ID = token.userId
        
        return Result.Success(user)
    }
    
    //MARK: - Error
    
    enum LoginError: Error {
        case emptyUser
        case cancelledByUser
    }
}
