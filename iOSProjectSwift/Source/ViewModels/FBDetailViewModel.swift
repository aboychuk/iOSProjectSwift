//
//  FBDetailViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/5/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBDetailViewModel: ViewModelProtocol {
    
    struct Input {
        let didTapOnFriends: AnyObserver<Void>
        let didTapOnLogout: AnyObserver<Void>
    }
    
    struct Output {
        let userObservable: Observable<FBUser>
        let friendsObservable: Observable<Void>
        let logoutObservable: Observable<Void>
        let errorObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private var service: FBGetUserDetailService
    private let friendsButtonSubject = PublishSubject<Void>()
    private let logoutButtonSubject = PublishSubject<Void>()
    private let userSubject = PublishSubject<FBUser>()
    private let errorSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(service: FBGetUserDetailService) {
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
        viewModel.service.load()
            .subscribe(
                onNext: { result in
                    switch result {
                    case .success(let user):
                        viewModel.userSubject.onNext(user)
                    case .failure(let error):
                        viewModel.errorSubject.onNext(error)
                    }
            })
            .disposed(by: viewModel.disposeBag)
    }
}
