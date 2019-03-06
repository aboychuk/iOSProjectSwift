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
        let nameObservable: Observable<String>
        let imageObservable: Observable<UIImage>
        let logoutObservable: Observable<FBCurrentUser>
    }
    
    // MARK: - Properties
    
    let input: Input
    let output: Output
    private var user: FBUser
    
    // MARK: - Init
    
    init(service: ) {
        <#statements#>
    }
}
