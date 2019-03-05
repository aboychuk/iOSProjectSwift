//
//  FBLoginViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 12/29/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FBLoginViewModel: ViewModelProtocol {
    
    struct Input {
        let didTapOnLogin: AnyObserver<Void>
    }
    
    struct Output {
        let authorizedObservable: Observable<FBCurrentUser>
        let errorObservable: Driver<Error>
    }
    
    //MARK: - Properties
    
    let input: Input
    let output: Output
    private let loginButtonSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    private let authorizedSubject = PublishSubject<FBCurrentUser>()
    private var user: FBCurrentUser
    
    //MARK: - Init
    
    init(user: FBCurrentUser) {
        self.user = user
        self.input = Input(didTapOnLogin: self.loginButtonSubject.asObserver())
        self.output = Output(authorizedObservable: self.authorizedSubject.asObservable(), errorObservable: self.errorSubject.asDriver(onErrorJustReturn: LoginViewModelError.defaultError))
    }
    
    //MARK: - Private methods
    
    private func setup() {

    }
    
    func authorize() {
//        FBLoginContext(user: self.user, subject: self.subject).execute()
    }
    
    // MARK: - Error
    
    private enum LoginViewModelError: Error {
        case defaultError
    }
}
