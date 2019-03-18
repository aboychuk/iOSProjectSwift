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
        let authorizedObservable: Observable<FBCurrentUser>
        let errorObservable: Observable<Error>
    }
    
    //MARK: - Properties
    
    let input: Input
    let output: Output
    private let loginButtonSubject = PublishSubject<Void>()
    private let errorSubject = PublishSubject<Error>()
    private let authorizedSubject = PublishSubject<FBCurrentUser>()
    private let disposeBag = DisposeBag()
    private let service: FBLoginService
    
    //MARK: - Init
    
    init(service: FBLoginService) {
        self.service = service
        self.input = Input(didTapOnLogin: self.loginButtonSubject.asObserver())
        self.output = Output(authorizedObservable: self.authorizedSubject.asObservable(),
                             errorObservable: self.errorSubject.asObservable())
        self.setup()
    }
    
    //MARK: - Private methods
    
    private func setup() {
        let viewModel = self
        viewModel.service.login()
            .subscribe(
                onNext: { result in
                    switch result {
                    case .success(let user): viewModel.authorizedSubject.onNext(user)
                    case .failure(let error): viewModel.errorSubject.onNext(error)
                    }
            })
            .disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - Error
    
    private enum LoginViewModelError: Error {
        case unknownError
    }
}
