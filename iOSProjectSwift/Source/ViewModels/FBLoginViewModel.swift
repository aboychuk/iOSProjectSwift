//
//  FBLoginViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 12/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBLoginViewModel: ViewModelProtocol {
    
    let input = Input {
        let didTapLoginButton: AnyObserver<Void>
    }
    
    let output = Output {
        
    }
    
    //MARK: - Properties
    
    let subject = PublishSubject<Result<FBCurrentUserModel>>()
    private var user: FBCurrentUserModel
    
    //MARK: - Init
    
    init(user: FBCurrentUserModel) {
        self.user = user
    }
    
    //MARK: - Public methods
    
    func authorize() {
        FBLoginContext(user: self.user, subject: self.subject).execute()
    }
}
