//
//  FBUserCellViewModel.swift
//  iOSProjectSwift
//
//  Created by Andrew Boychuk on 3/18/19.
//  Copyright © 2019 Andrew Boychuk. All rights reserved.
//

import Foundation
import RxSwift

class FBUserCellViewModel: ViewModelType {
    struct Input {
        let user: AnyObserver<FBUser>
    }
    
    struct Output {
        let nameObservable: Observable<String>
        let imageObservable: Observable<UIImage>
    }
    
    
    // MARK: - Properties
    
    let model: FBUser
    
    // MARK: - Init
    
    init(model: FBUser) {
        self.model = model
    }
    
}
