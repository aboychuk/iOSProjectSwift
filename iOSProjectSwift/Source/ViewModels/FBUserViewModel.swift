//
//  FBUserViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/5/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBUserViewModel: ViewModelType {
    
    struct Input {
        let didTapOnFriends: AnyObserver<Void>
        let didTapOnLogout: AnyObserver<Void>
    }
    
    struct Output {
        let userObservable: Observable<UserType>
        let friendsObservable: Observable<Void>
        let logoutObservable: Observable<Void>
        let errorObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let service: FBGetUserService
    private let friendsButtonSubject = PublishSubject<Void>()
    private let logoutButtonSubject = PublishSubject<Void>()
    private let userSubject = PublishSubject<UserType>()
    private let errorSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    private var user: UserType = User()
    
    // MARK: - Init
    
    init(service: FBGetUserService) {
        self.service = service
        self.input = Input(didTapOnFriends: self.friendsButtonSubject.asObserver(),
                           didTapOnLogout: self.logoutButtonSubject.asObserver())
        self.output = Output(userObservable: self.userSubject.asObservable(),
                             friendsObservable: self.friendsButtonSubject.asObservable(),
                             logoutObservable: self.logoutButtonSubject.asObservable(),
                             errorObservable: self.errorSubject.asObservable())
        self.setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        let viewModel = self
        viewModel
            .service
            .load()
            .subscribe(
                onNext: { [weak self] result in
                    switch result {
                    case .success(let user):
                        self?.user = user
                        viewModel.userSubject.onNext(user)
                    case .failure(let error):
                        viewModel.errorSubject.onNext(error)
                    }
            })
            .disposed(by: viewModel.disposeBag)
        
        viewModel
            .friendsButtonSubject
            .subscribe { [unowned self] in
                self.userSubject.onNext(self.user)
            }
            .disposed(by: self.disposeBag)
        
        viewModel
            .logoutButtonSubject
            .subscribe {
                self.userSubject.onNext(self.user)
            }
            .disposed(by: self.disposeBag)
    }
}
