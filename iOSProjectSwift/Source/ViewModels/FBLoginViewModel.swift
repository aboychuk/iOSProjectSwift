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

class FBLoginViewModel: ViewModelType {
    
    struct Input {
        let didTapOnLogin: AnyObserver<Void>
    }
    
    struct Output {
        let authorizedObservable: Observable<Credentials>
        let errorObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let credentials: Credentials
    private let loginButtonSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    private let authorizedSubject = PublishSubject<Credentials>()
    private let disposeBag = DisposeBag()
    private let service = FBAuthenticationService()
    
    // MARK: - Init
    
    init(credentials: Credentials) {
        self.credentials = credentials
        self.input = Input(didTapOnLogin: self.loginButtonSubject.asObserver())
        self.output = Output(authorizedObservable: self.authorizedSubject.asObservable(),
                             errorObservable: self.errorSubject.asObservable())
        self.setup()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        self.loginButtonSubject
            .subscribe(
                onNext: { [weak self] in
                    self?.loginUser()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func loginUser() {
        self.service
            .login(credentials: self.credentials)
            .subscribe(
                onNext: { [weak self] result in
                    switch result {
                    case .success(let credentials):
                        self?.authorizedSubject.onNext(credentials)
                    case .failure(let error):
                        self?.errorSubject.onNext(error)
                    }
            })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - Error
    
    private enum LoginViewModelError: Error {
        case unknownError
    }
}
