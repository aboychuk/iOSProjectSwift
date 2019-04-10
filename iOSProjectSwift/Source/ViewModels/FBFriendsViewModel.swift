//
//  FBFriendsViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/7/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBFriendsViewModel: ViewModelType {
    typealias Friends = ArrayModel<User>
    
    struct Input {
        let didSelectModelAtindex: AnyObserver<Void>
    }
    
    struct Output {
        let friendObservable: Observable<User>
        let friendsObservable: Observable<Friends>
        let errorObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let service: FBGetFriendsService
    private let didSelectFriend = PublishSubject<Void>()
    private let friendSubject = PublishSubject<User>()
    private let friendsSubject = PublishSubject<Friends>()
    private let errorSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(service: FBGetFriendsService) {
        self.service = service
        self.input = Input(didSelectModelAtindex: self.didSelectFriend.asObserver())
        self.output = Output(friendObservable: self.friendSubject.asObservable(),
                             friendsObservable: self.friendsSubject.asObservable(),
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
                    case .success(let friends):
                        self?.friendsSubject.onNext(friends)
                    case .failure(let error):
                        self?.errorSubject.onNext(error)
                    }
            })
            .disposed(by: self.disposeBag)
    }
    
}
