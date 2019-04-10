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
    typealias Friends = ArrayModel<User>
    
    struct Input {
        let didTapOnFriends: AnyObserver<Void>
        let didTapOnLogout: AnyObserver<Void>
    }
    
    struct Output {
        let userObservable: Observable<UserType>
        let friendsObservable: Observable<Friends>
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
    private let friendsSubject = PublishSubject<Friends>()
    private let errorSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    private var user: UserType = User()
    
    // MARK: - Init
    
    init(service: FBGetUserService) {
        self.service = service
        self.input = Input(didTapOnFriends: self.friendsButtonSubject.asObserver(),
                           didTapOnLogout: self.logoutButtonSubject.asObserver())
        self.output = Output(userObservable: self.userSubject.asObservable(),
                             friendsObservable: self.friendsSubject.asObservable(),
                             logoutObservable: self.logoutButtonSubject.asObservable(),
                             errorObservable: self.errorSubject.asObservable())
        self.setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        self.service
            .load()
            .subscribe(
                onNext: { [weak self] result in
                    switch result {
                    case .success(let user):
                        self?.user = user
                        self?.userSubject.onNext(user)
                    case .failure(let error):
                        self?.errorSubject.onNext(error)
                    }
            })
            .disposed(by: self.disposeBag)
        
        self.friendsButtonSubject
            .subscribe(onNext: { [unowned self] in
                let friendsModel = ArrayModel<User>()
                self.friendsSubject.onNext(friendsModel)
            })
            .disposed(by: self.disposeBag)
        
        self.logoutButtonSubject.subscribe(onNext: { [unowned self] in
                self.userSubject.onNext(self.user)
            })
            
            .disposed(by: self.disposeBag)
    }
}
