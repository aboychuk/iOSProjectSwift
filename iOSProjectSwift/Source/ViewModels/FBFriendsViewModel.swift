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
    
    struct Input {
        let didSelectModelAtindex: AnyObserver<Void>
    }
    
    struct Output {
        let userObservable: Observable<[FBUser]>
        let errorObservable: Observable<Error>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private let service: FBGetFriendsService
    private let userSubject = PublishSubject<[FBUser]>()
    private let errorSubject = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(service: FBGetFriendsService) {
        self.service = service
        self.input = Input(didSelectModelAtindex: <#T##AnyObserver<Void>#>)
        self.output = Output(userObservable: self.userSubject.asObservable(),
                             errorObservable: self.errorSubject.asObservable())
        self.setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        
    }
    
}
