//
//  FBLoginViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 12/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBLoginViewModel {
    
    //MARK: - Properties
    
    var user: FBCurrentUserModel
    var disposeBag = DisposeBag()
    var didTapLoginButton: PublishSubject<Void> = PublishSubject()
    var didLogin: PublishSubject<FBCurrentUserModel> = PublishSubject()
    
    //MARK: - Initializations
    
    init(user: FBCurrentUserModel) {
        self.user = user
        
        self.didTapLoginButton.subscribe(onNext: {
            FBLoginContext(model: self.user).execute()
        }).disposed(by: self.disposeBag)
    }
}
